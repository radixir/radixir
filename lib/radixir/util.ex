defmodule Radixir.Util do
  @moduledoc """
  Utility functions that do various things.
  """
  alias Radixir.Config
  alias Radixir.Crypto
  alias Radixir.Key

  @type private_key :: String.t()
  @type public_key :: String.t()
  @type address :: String.t()
  @type message :: String.t()
  @type encrypted_message :: String.t()
  @type encoded_message :: String.t()
  @type data :: String.t()
  @type atto :: String.t()
  @type xrd :: String.t()
  @type encoded_data :: String.t()
  @type error_note :: String.t()
  @type unsigned_transaction :: String.t()
  @type payload_to_sign :: String.t()
  @type error_message :: String.t()
  @type keys_values :: list(keyword)
  @type rounding ::
          :down | :half_up | :half_even | :ceiling | :floor | :half_down | :up

  @doc """
  Encrypts message with private_key and address.

  ## Parameters
    - `message`: Plain text message to be encrypted.
    - `private_key`: Hex encoded private key.
    - `address`: Radix address.

  ## Examples

      Radixir.Util.encrypt_message("hello there","83c060ae328c1e8bd238939aa78098c8eee5e18fc857ca3cc10336ad204e8f69", "rdx1qsp29qfgpy79ne7g92s8r5mvrzngyugf750ut7u76qtr9v0kzlt3pzgqr7vv6")
      {:ok,
      "01ff02479eac3d0e685437e3ec1c6401db8895c4ead94f2906c3380c6d442f9496c71d3b28e578a98284b112d1c3c7d45bb407e9c778d7ac3ec9349f9d517abee7bad13c521e517bc86f"}
  """
  @spec encrypt_message(message, private_key, address) ::
          {:ok, encrypted_message} | {:error, error_message}
  def encrypt_message(message, private_key, address) do
    with private_key <- String.downcase(private_key),
         {:ok, _} <- Key.from_private_key(private_key),
         address <- String.downcase(address),
         {:ok, _} <- Key.address_to_public_key(address),
         {:ok, dh} <- get_dh(private_key, address),
         {key_bytes, ephemeral_public_key_bytes, nonce_bytes} <- get_encryption_params(dh),
         {:ok, {_ad, payload}} <-
           Crypto.encrypt(key_bytes, ephemeral_public_key_bytes, nonce_bytes, message),
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
  Decrypts encrypted_message with private_key and address.

  ## Parameters
    - `encrypted_message`: Encrypted message to be decrypted.
    - `private_key`: Hex encoded private key.
    - `address`: Radix address.

  ## Examples

      Radixir.Util.decrypt_message("01ff02479eac3d0e685437e3ec1c6401db8895c4ead94f2906c3380c6d442f9496c71d3b28e578a98284b112d1c3c7d45bb407e9c778d7ac3ec9349f9d517abee7bad13c521e517bc86f","b6b71fb3936ee2c7b6398bc5a25138292e0b470642bf70e1cea7f52707bce0e5", "rdx1qspzfaq8ccfzmrrx9xxqrm6uespgtt7mah0ry3qa2vsxajk462s5ttsmphsk4")
      {:ok, "hello there"}
  """
  @spec decrypt_message(encrypted_message, private_key, address) ::
          {:ok, message} | {:error, error_message}
  def decrypt_message(encrypted_message, private_key, address) do
    with private_key <- String.downcase(private_key),
         {:ok, _} <- Key.from_private_key(private_key),
         address <- String.downcase(address),
         {:ok, _} <- Key.address_to_public_key(address),
         {:ok, dh} <- get_dh(private_key, address),
         {key_bytes, ephemeral_public_key_bytes, nonce_bytes, cipher_text_bytes, cipher_tag_bytes} <-
           get_decryption_params(encrypted_message, dh) do
      Crypto.decrypt(
        key_bytes,
        ephemeral_public_key_bytes,
        nonce_bytes,
        cipher_text_bytes,
        cipher_tag_bytes
      )
    end
  end

  @doc """
  Encodes message by:
    - Base16 encoding the message
    - Prefixing "0000" to the front

  ## Parameter
    - `message`: Plain text.

  ## Examples

      iex> Radixir.Util.encode_message("hello there")
      "000068656c6c6f207468657265"
  """
  @spec encode_message(message) :: encoded_message
  def encode_message(message) do
    message
    |> encode16()
    |> String.replace_prefix("", "0000")
  end

  @doc """
  Decodes a message.

  ## Parameter
    - `encoded_message`: Encoded message.

  ## Examples

      iex> Radixir.Util.decode_message("000068656c6c6f207468657265")
      {:ok, "hello there"}
  """
  @spec decode_message(encoded_message) :: {:ok, message} | {:error, error_message}
  def decode_message(encoded_message), do: do_decode_message(encoded_message)

  @doc """
  Verifies double hash of base16 decoded unsigned_transaction matches payload_to_sign.
  """
  @spec verify_hash(unsigned_transaction, payload_to_sign) :: :ok | {:error, error_message}
  def verify_hash(unsigned_transaction, payload_to_sign) do
    with {:ok, unsigned_transaction_binary} <-
           decode16(unsigned_transaction, "unsigned_transaction") do
      double_hash =
        unsigned_transaction_binary
        |> hash()
        |> hash()
        |> encode16()

      if double_hash == payload_to_sign do
        :ok
      else
        {:error, "double hash of unsigned_transaction does not match payload_to_sign"}
      end
    end
  end

  @doc """
  Base16 encodes data.

  ## Parameters
    - `data`: Data to be encoded.

  ## Examples

      iex> Radixir.Util.encode16("hello there")
      "68656c6c6f207468657265"
  """
  @spec encode16(data) :: encoded_data
  def encode16(data), do: Base.encode16(data, case: :lower)

  @doc """
  Base16 decodes encoded_data.

  ## Parameters
    - `encoded_data`: Data to be decoded.
    - `error_note`: Note to add to error message.

  ## Examples

      iex> Radixir.Util.decode16("68656c6c6f207468657265", "obi wan's message")
      {:ok, "hello there"}

      iex> Radixir.Util.decode16("zzzz", "obi wan's message")
      {:error, "could not base16 decode obi wan's message"}
  """
  @spec decode16(encoded_data, error_note) :: {:ok, data} | {:error, error_message}
  def decode16(encoded_data, error_note) do
    with {:ok, result} <- Base.decode16(encoded_data, case: :mixed) do
      {:ok, result}
    else
      _ ->
        {:error, "could not base16 decode #{error_note}"}
    end
  end

  @doc """
  Converts xrd to atto, smallest unit of value.

  ## Parameters
    - `xrd`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_to_atto("1.5")
      "1500000000000000000"
  """
  @spec xrd_to_atto(xrd) :: atto
  def xrd_to_atto(xrd) when is_binary(xrd) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})

    Decimal.new(xrd)
    |> Decimal.mult(Integer.pow(10, 18))
    |> Decimal.to_string(:normal)
    |> String.split(".")
    |> List.first()
  end

  @doc """
  Converts atto, the smallest unit of value, to xrd.

  ## Parameters
    - `atto`: Amount of XRD, in atto units.

  ## Examples

      iex> Radixir.Util.atto_to_xrd("1500000000000000000")
      "1.5"
  """
  @spec atto_to_xrd(atto) :: xrd
  def atto_to_xrd(atto) when is_binary(atto) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})

    atto
    |> String.split(".")
    |> List.first()
    |> Decimal.new()
    |> Decimal.div(Integer.pow(10, 18))
    |> Decimal.to_string(:normal)
  end

  @doc """
  Absolute value of XRD amount.

  ## Parameters
    - `num`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_abs("-1.5")
      "1.5"
  """
  @spec xrd_abs(String.t()) :: String.t()
  def xrd_abs(num) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num = num |> xrd_to_atto() |> atto_to_xrd()
    Decimal.new(num) |> Decimal.abs() |> Decimal.to_string(:normal)
  end

  @doc """
  Adds two XRD amounts.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_add("12.0000000000000000014", "12.0000000000000000014")
      "24.000000000000000002"
  """
  @spec xrd_add(String.t(), String.t()) :: String.t()
  def xrd_add(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.add(num1, num2) |> Decimal.to_string(:normal)
  end

  @doc """
  Compares two XRD amounts.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_compare("12.0000000000000000089", "12.0000000000000000079")
      :gt
  """
  @spec xrd_compare(String.t(), String.t()) :: :lt | :gt | :eq
  def xrd_compare(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.compare(num1, num2)
  end

  @doc """
  Divides two XRD amounts.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_div("10.4", "5.2")
      "2"
  """
  @spec xrd_div(String.t(), String.t()) :: String.t()
  def xrd_div(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.div(num1, num2) |> Decimal.to_string(:normal) |> xrd_to_atto() |> atto_to_xrd()
  end

  @doc """
  Divides two XRD amounts and returns the integer part.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_div_int("6.9","4.3")
      "1"
  """
  @spec xrd_div_int(String.t(), String.t()) :: String.t()
  def xrd_div_int(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.div_int(num1, num2) |> Decimal.to_string(:normal) |> xrd_to_atto() |> atto_to_xrd()
  end

  @doc """
  Divides two XRD amounts and returns the integer part and remainder part.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_div_rem("6","4.3")
      {"1", "1.7"}
  """
  @spec xrd_div_rem(String.t(), String.t()) :: {String.t(), String.t()}
  def xrd_div_rem(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    {integer_value, remainder_value} = Decimal.div_rem(num1, num2)

    {Decimal.to_string(integer_value, :normal) |> xrd_to_atto() |> atto_to_xrd(),
     Decimal.to_string(remainder_value, :normal) |> xrd_to_atto() |> atto_to_xrd()}
  end

  @doc """
  Checks if two XRD amounts are equal.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_equal?("1.0", "2.0")
      false
  """
  @spec xrd_equal?(String.t(), String.t()) :: boolean
  def xrd_equal?(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.equal?(num1, num2)
  end

  @doc """
  Checks if num1 is greater than num2.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_gt?("2.0", "3.0")
      false
  """
  @spec xrd_gt?(String.t(), String.t()) :: boolean
  def xrd_gt?(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.gt?(num1, num2)
  end

  @doc """
  Checks if num1 is less than num2.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_lt?("2.0", "3.0")
      true
  """
  @spec xrd_lt?(String.t(), String.t()) :: boolean
  def xrd_lt?(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.lt?(num1, num2)
  end

  @doc """
  Returns the max of two XRD amounts.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_max("1.3", "1")
      "1.3"
  """
  @spec xrd_max(String.t(), String.t()) :: String.t()
  def xrd_max(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.max(num1, num2) |> Decimal.to_string(:normal)
  end

  @doc """
  Returns the min of two XRD amounts.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_min("1.3", "1")
      "1"
  """
  @spec xrd_min(String.t(), String.t()) :: String.t()
  def xrd_min(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.min(num1, num2) |> Decimal.to_string(:normal)
  end

  @doc """
  Multiplies two XRD amounts.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_mult("5", "0.5")
      "2.5"
  """
  @spec xrd_mult(String.t(), String.t()) :: String.t()
  def xrd_mult(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.mult(num1, num2) |> Decimal.to_string(:normal) |> xrd_to_atto() |> atto_to_xrd()
  end

  @doc """
  Negates the given XRD amount.

  ## Parameters
    - `num`: Amount of XRD.

  ## Example

      iex> Radixir.Util.xrd_negate("2.5")
      "-2.5"
  """
  @spec xrd_negate(String.t()) :: String.t()
  def xrd_negate(num) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num = num |> xrd_to_atto() |> atto_to_xrd()
    Decimal.negate(num) |> Decimal.to_string(:normal)
  end

  @doc """
  Checks if an XRD amount is negative.

  ## Parameters
    - `num`: Amount of XRD.

  ## Example

      iex> Radixir.Util.xrd_negative?("-1.34")
      true
  """
  @spec xrd_negative?(String.t()) :: boolean
  def xrd_negative?(num) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num = num |> xrd_to_atto() |> atto_to_xrd()
    Decimal.new(num) |> Decimal.negative?()
  end

  @doc """
  Checks if an XRD amount is positive.

  ## Parameters
    - `num`: Amount of XRD.

  ## Example

      iex> Radixir.Util.xrd_positive?("-1.34")
      false
  """
  @spec xrd_positive?(String.t()) :: boolean
  def xrd_positive?(num) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num = num |> xrd_to_atto() |> atto_to_xrd()
    Decimal.new(num) |> Decimal.positive?()
  end

  @doc """
  Returns the remainder of integer division of two XRD amounts.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_rem("5.0", "2")
      "1"
  """
  @spec xrd_rem(String.t(), String.t()) :: String.t()
  def xrd_rem(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.rem(num1, num2) |> Decimal.to_string(:normal) |> xrd_to_atto() |> atto_to_xrd()
  end

  @doc """
  Rounds an XRD amount.

  ## Parameters
    - `num`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_round("1.6")
      "2"
  """
  @spec xrd_round(String.t(), integer, rounding) :: String.t()
  def xrd_round(num, places \\ 0, mode \\ :half_up) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num = num |> xrd_to_atto() |> atto_to_xrd()

    Decimal.round(num, places, mode)
    |> Decimal.to_string(:normal)
    |> xrd_to_atto()
    |> atto_to_xrd()
  end

  @doc """
  Finds square root of XRD amount.

  ## Parameters
    - `num`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_sqrt("36")
      "6"
  """
  @spec xrd_sqrt(String.t()) :: String.t()
  def xrd_sqrt(num) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num = num |> xrd_to_atto() |> atto_to_xrd()
    Decimal.sqrt(num) |> Decimal.to_string(:normal) |> xrd_to_atto() |> atto_to_xrd()
  end

  @doc """
  Subtracts two XRD amounts.

  ## Parameters
    - `num1`: Amount of XRD.
    - `num2`: Amount of XRD.

  ## Examples

      iex> Radixir.Util.xrd_sub("5", "2")
      "3"
  """
  @spec xrd_sub(String.t(), String.t()) :: String.t()
  def xrd_sub(num1, num2) do
    Decimal.Context.set(%Decimal.Context{Decimal.Context.get() | precision: 100})
    num1 = num1 |> xrd_to_atto() |> atto_to_xrd()
    num2 = num2 |> xrd_to_atto() |> atto_to_xrd()
    Decimal.sub(num1, num2) |> Decimal.to_string(:normal) |> xrd_to_atto() |> atto_to_xrd()
  end

  # @doc """
  # Stitches together stitch plans which results in a map.

  # ## Parameters
  #   - `keys_values`: List of keyword lists.

  # ## Examples
  #     iex> Radixir.Util.stitch([[keys: [:a, :b, :c], value: 4],[keys: [:z, :y, :x], value: 90]])
  #     %{a: %{b: %{c: 4}}, z: %{y: %{x: 90}}}
  # """
  @doc false
  @spec stitch(keys_values) :: map
  def stitch(keys_values) do
    # [[keys: [:a, :b, :c], value: 4],[keys: [:z, :y, :x], value: 90]]
    Enum.reduce(keys_values, %{}, fn x, data ->
      map_put(data, x[:keys], x[:value])
    end)
  end

  @doc false
  def take_and_drop(options, keys) do
    {Keyword.take(options, keys), Keyword.drop(options, keys)}
  end

  @doc false
  def maybe_create_stitch_plan(stitch_plans, [], _function), do: stitch_plans

  @doc false
  def maybe_create_stitch_plan(stitch_plans, params, function),
    do: function.(stitch_plans, params)

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

    case url do
      {:ok, url} ->
        {:ok, url, options}

      {:error, error} ->
        {:error, error}

      url ->
        {:ok, url, options}
    end
  end

  @doc false
  def get_mnemonic_from_options(options) do
    case Keyword.get(options, :mnemonic) do
      nil ->
        Config.mnemonic()

      result ->
        {:ok, result}
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

  defp do_decode_message("0000" <> message), do: decode16(message, "message")

  defp do_decode_message("30303030" <> message) do
    with {:ok, result} <- decode16(message, "message"),
         {:ok, result} <- decode16(result, "message") do
      {:ok, result}
    end
  end

  defp do_decode_message(_), do: {:error, "invalid message format"}

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

  defp get_dh(private_key, address) do
    with {:ok, private_key_secret} <- Key.private_key_to_secret_integer(private_key),
         {:ok, public_key} <- Key.address_to_public_key(address),
         {:ok, public_key_binary} <- decode16(public_key, "public_key"),
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
    key_bytes = :scrypt.scrypt(shared_secret_bytes, salt_bytes, 8192, 8, 1, 32)
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
      key_bytes = :scrypt.scrypt(shared_secret_bytes, salt_bytes, 8192, 8, 1, 32)
      {key_bytes, ephemeral_public_key_bytes, nonce_bytes, cipher_text_bytes, cipher_tag_bytes}
    end
  end
end
