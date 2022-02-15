defmodule Radixir.Util do
  @moduledoc """
  Utility functions that do various things.
  """
  alias Radixir.Config
  alias Radixir.Key

  @type private_key :: String.t()
  @type public_key :: String.t()
  @type address :: String.t()
  @type message :: String.t()
  @type encrypted_message :: String.t()
  @type encoded_message :: String.t()
  @type data :: String.t()
  @type encoded_data :: String.t()
  @type error_note :: String.t()
  @type unsigned_transaction :: String.t()
  @type payload_to_sign :: String.t()
  @type error_message :: String.t()
  @type keys_values :: list(list())

  @doc """
  Encrypts `message` with `private_key` and `address`.

  ## Parameters
    - `message`: Plain text message to be encrypted.
    - `private_key`: Hex encoded private key.
    - `address`: Radix address.
  """
  @spec encrypt_message(message, private_key, address) ::
          {:ok, encrypted_message} | {:error, error_message}
  def encrypt_message(message, private_key, address) do
    with private_key <- String.downcase(private_key),
         {:ok, private_key} <- Key.validate_private_key(private_key),
         address <- String.downcase(address),
         {:ok, address} <- Key.validate_address(address),
         {:ok, dh} <- get_dh(private_key, address),
         {key_bytes, ephemeral_public_key_bytes, nonce_bytes} <- get_encryption_params(dh),
         {:ok, {_ad, payload}} <-
           ExCrypto.encrypt(key_bytes, ephemeral_public_key_bytes, nonce_bytes, message),
         {_iv, cipher_text_bytes, cipher_tag_bytes} <- payload do
      {:ok,
       encode16(
         <<1>> <>
           <<255>> <>
           ephemeral_public_key_bytes <> nonce_bytes <> cipher_tag_bytes <> cipher_text_bytes
       )}
    end
  end

  @doc """
  Decrypts `encrypted_message` with `private_key` and `address`.

  ## Parameters
    - `encrypted_message`: Encrypted message to be decrypted.
    - `private_key`: Hex encoded private key.
    - `address`: Radix address.
  """
  @spec decrypt_message(encrypted_message, private_key, address) ::
          {:ok, message} | {:error, error_message}
  def decrypt_message(encrypted_message, private_key, address) do
    with private_key <- String.downcase(private_key),
         {:ok, private_key} <- Key.validate_private_key(private_key),
         address <- String.downcase(address),
         {:ok, address} <- Key.validate_address(address),
         {:ok, dh} <- get_dh(private_key, address),
         {key_bytes, ephemeral_public_key_bytes, nonce_bytes, cipher_text_bytes, cipher_tag_bytes} <-
           get_decryption_params(encrypted_message, dh) do
      ExCrypto.decrypt(
        key_bytes,
        ephemeral_public_key_bytes,
        nonce_bytes,
        cipher_text_bytes,
        cipher_tag_bytes
      )
    end
  end

  @doc """
  Encodes `message` by:
    - Base16 encoding the message
    - Prefixing "0000" to the front

  ## Parameter
    - `message`: Plain text.
  """
  @spec encode_message(message) :: encoded_message
  def encode_message(message) do
    message
    |> encode16()
    |> String.replace_prefix("", "0000")
  end

  @doc """
  Decodes a message.
  """
  @spec decode_message(encoded_message) :: {:ok, message} | {:error, error_message}
  def decode_message(encoded_message), do: do_decode_message(encoded_message)

  @doc """
  Verifies double hash of `unsigned_transaction` matches `payload_to_sign`.
  """
  @spec verify_hash(unsigned_transaction, payload_to_sign) :: :ok | {:error, error_message}
  def verify_hash(unsigned_transaction, payload_to_sign) do
    with {:ok, unsigned_transaction_binary} <-
           decode16(unsigned_transaction, "unsigned_transaction") do
      double_hash_hex =
        unsigned_transaction_binary
        |> hash()
        |> hash()
        |> encode16()

      if double_hash_hex == payload_to_sign do
        :ok
      else
        {:error, "double hash of unsigned_transaction does not match payload_to_sign"}
      end
    end
  end

  @doc """
  Base16 encodes `data`.
  """
  @spec encode16(data) :: encoded_data
  def encode16(data), do: Base.encode16(data, case: :lower)

  @doc """
  Base16 decodes `encoded_data`.
  """
  @spec decode16(encoded_data, error_note) :: {:ok, data} | {:error, error_message}
  def decode16(encoded_data, error_note) do
    with {:ok, result} <- Base.decode16(encoded_data, case: :mixed) do
      {:ok, result}
    else
      _ ->
        {:error, "could not decode #{error_note}"}
    end
  end

  @doc """
  Stitches together stitch plans which results in a map.

  ## Parameters
    - `keys_values`: List of keyword lists.

  ## Example

      iex> Radixir.Util.stitch([[keys: [:a, :b, :c], value: 4],[keys: [:z, :y, :x], value: 90]])
      %{a: %{b: %{c: 4}}, z: %{y: %{x: 90}}}
  """
  @spec stitch(keys_values) :: map()
  def stitch(keys_values) do
    # [[keys: [:a, :b, :c], value: 4],[keys: [:z, :y, :x], value: 90]]
    Enum.reduce(keys_values, %{}, fn x, data ->
      map_put(data, x[:keys], x[:value])
    end)
  end

  defp do_decode_message("0000" <> message), do: decode16(message, "message")

  defp do_decode_message("30303030" <> message) do
    with {:ok, result} <- decode16(message, "message"),
         {:ok, result} <- decode16(result, "message") do
      {:ok, result}
    end
  end

  @doc false
  def hash(data), do: :crypto.hash(:sha256, data)

  @doc false
  def get_url_from_options(options, api) do
    url =
      case api do
        :gateway ->
          Keyword.get(options, :url, Config.gateway_api_url())

        :core ->
          Keyword.get(options, :url, Config.core_api_url())

        :system ->
          Keyword.get(options, :url, Config.system_api_url())
      end

    options = Keyword.delete(options, :url)

    if url do
      {:ok, url, options}
    else
      {:error, "no url available"}
    end
  end

  @doc false
  def get_auth_from_options(options) do
    {username, options} = get_username_from_options(options)
    {password, options} = get_password_from_options(options)
    {auth_index, options} = get_auth_index_from_options(options)

    parse_auth_results(username, password, auth_index, options)
  end

  @doc false
  def optional_params(nil, _keys), do: []

  @doc false
  def optional_params(value, keys) do
    [keys: keys, value: value]
  end

  @doc false
  def map_put(data, keys, value) do
    put_in(data, Enum.map(keys, &Access.key(&1, %{})), value)
  end

  defp parse_auth_results(nil = _username, nil = _password, nil = _auth_index, _options),
    do: {:error, "no auth provided"}

  defp parse_auth_results(_username, nil = _password, nil = _auth_index, _options),
    do: {:error, "no password provided"}

  defp parse_auth_results(nil = _username, _password, nil = _auth_index, _options),
    do: {:error, "no username provided"}

  defp parse_auth_results(nil = _username, nil = _password, auth_index, options) do
    with {:ok, username, password} <- Config.auth(auth_index) do
      {:ok, username, password, options}
    end
  end

  defp parse_auth_results(username, password, nil = _auth_index, options),
    do: {:ok, username, password, options}

  defp parse_auth_results(username, password, _auth_index, options),
    do: {:ok, username, password, options}

  defp get_username_from_options(options) do
    username = Keyword.get(options, :username)
    options = Keyword.delete(options, :username)
    {username, options}
  end

  defp get_password_from_options(options) do
    password = Keyword.get(options, :password)
    options = Keyword.delete(options, :password)
    {password, options}
  end

  defp get_auth_index_from_options(options) do
    auth_index = Keyword.get(options, :auth_index)
    options = Keyword.delete(options, :auth_index)
    {auth_index, options}
  end

  defp get_dh(private_key_hex, address) do
    with {:ok, private_key_secret} <- Key.private_key_to_secret_integer(private_key_hex),
         {:ok, public_key_hex} <- Key.address_to_public_key(address),
         {:ok, public_key_binary} <- decode16(public_key_hex, "public_key_hex"),
         public_keypair <- Curvy.Key.from_pubkey(public_key_binary) do
      {:ok, Curvy.Point.mul(public_keypair.point, private_key_secret)}
    end
  end

  defp get_encryption_params(dh) do
    ephemeral_keypair = Curvy.generate_key()
    ephemeral_public_key_bytes = Curvy.Key.to_pubkey(ephemeral_keypair)
    shared_secret_point = Curvy.Point.add(ephemeral_keypair.point, dh)
    shared_secret_integer = shared_secret_point.x
    shared_secret_bytes = :binary.encode_unsigned(shared_secret_integer, :big)
    nonce_bytes = :crypto.strong_rand_bytes(12)
    salt_bytes = :crypto.hash(:sha256, nonce_bytes)
    key_bytes = :scrypt.scrypt(shared_secret_bytes, salt_bytes, 32, 8192, 8, 32)
    {key_bytes, ephemeral_public_key_bytes, nonce_bytes}
  end

  defp get_decryption_params(message, dh) do
    with 148 <- String.length(message),
         {:ok, ephemeral_public_key_bytes} <-
           String.slice(message, 4..69) |> decode16("ephemeral_public_key from encrypted message"),
         ephemeral_keypair <- Curvy.Key.from_pubkey(ephemeral_public_key_bytes),
         {:ok, nonce_bytes} <-
           String.slice(message, 70..93) |> decode16("nonce from encrypted message"),
         {:ok, cipher_tag_bytes} <-
           String.slice(message, 94..125) |> decode16("cipher_tag from encrypted message"),
         {:ok, cipher_text_bytes} <-
           String.slice(message, 126..-1) |> decode16("cipher_text from encrypted message") do
      shared_secret_point = Curvy.Point.add(ephemeral_keypair.point, dh)
      shared_secret_integer = shared_secret_point.x
      shared_secret_bytes = :binary.encode_unsigned(shared_secret_integer, :big)
      salt_bytes = :crypto.hash(:sha256, nonce_bytes)
      key_bytes = :scrypt.scrypt(shared_secret_bytes, salt_bytes, 32, 8192, 8, 32)
      {key_bytes, ephemeral_public_key_bytes, nonce_bytes, cipher_text_bytes, cipher_tag_bytes}
    end
  end
end
