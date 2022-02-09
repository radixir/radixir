defmodule Radixir.Util do
  alias Radixir.Config
  alias Radixir.Key

  def hash(data), do: :crypto.hash(:sha256, data)

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

  def encode_message(message) do
    message
    |> Base.encode16()
    |> String.replace_prefix("", "0000")
  end

  def get_url_from_options(options) do
    url = Keyword.get(options, :url, Config.radix_gateway_api_url())
    options = Keyword.delete(options, :url)
    {url, options}
  end

  def get_auth_from_options(options) do
    {username, options} = get_username_from_options(options)
    {password, options} = get_password_from_options(options)
    {auth_index, options} = get_auth_index_from_options(options)

    parse_auth_results(username, password, auth_index, options)
  end

  defp parse_auth_results(nil = _username, nil = _password, nil = _auth_index, _options),
    do: {:error, "no auth provided"}

  defp parse_auth_results(_username, nil = _password, nil = _auth_index, _options),
    do: {:error, "no password provided"}

  defp parse_auth_results(nil = _username, _password, nil = _auth_index, _options),
    do: {:error, "no username provided"}

  defp parse_auth_results(nil = _username, nil = _password, auth_index, options) do
    with {:ok, username, password} <- Config.radix_auth(auth_index) do
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

  def encrypt_message(message, private_key_hex, radix_address) do
    with {:ok, dh} <- get_dh(private_key_hex, radix_address),
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

  def decode_message("0000" <> message), do: decode16(message, "message")

  def decode_message("30303030" <> message) do
    with {:ok, result} <- decode16(message, "message"),
         {:ok, result} <- decode16(result, "message") do
      {:ok, result}
    end
  end

  def decrypt_message(message, private_key_hex, radix_address) do
    with {:ok, dh} <- get_dh(private_key_hex, radix_address),
         {key_bytes, ephemeral_public_key_bytes, nonce_bytes, cipher_text_bytes, cipher_tag_bytes} <-
           get_decryption_params(message, dh) do
      ExCrypto.decrypt(
        key_bytes,
        ephemeral_public_key_bytes,
        nonce_bytes,
        cipher_text_bytes,
        cipher_tag_bytes
      )
    end
  end

  def decode16(data_hex, info) do
    with {:ok, result} <- Base.decode16(data_hex, case: :mixed) do
      {:ok, result}
    else
      _ ->
        {:error, "could not decode #{info}"}
    end
  end

  def encode16(data), do: Base.encode16(data, case: :lower)

  def optional_params(nil, _keys), do: []

  def optional_params(value, keys) do
    [keys: keys, value: value]
  end

  def stitch(keys_values, data \\ %{}) do
    # [[keys: [:a, :b, :c], value: 4],[keys: [:z, :y, :x], value: 90]]
    Enum.reduce(keys_values, data, fn x, data ->
      map_put(data, x[:keys], x[:value])
    end)
  end

  def map_put(data, keys, value) do
    put_in(data, Enum.map(keys, &Access.key(&1, %{})), value)
  end

  defp get_dh(private_key_hex, radix_address) do
    with {:ok, private_key_secret} <- Key.private_key_to_secret(private_key_hex),
         {:ok, public_key_hex} <- Key.address_to_public_key(radix_address),
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
