defmodule Radixir.Utils do
  alias Radixir.Keys

  def double_hash(data) do
    result = :crypto.hash(:sha256, data)
    :crypto.hash(:sha256, result)
  end

  def verify_hash(unsigned_transaction, payload_to_sign) do
    binary_unsigned_transaction = decode_data(unsigned_transaction)

    double_hash_hex =
      binary_unsigned_transaction
      |> double_hash()
      |> Curvy.Util.encode(:hex)

    if double_hash_hex == payload_to_sign do
      :ok
    else
      {:error, "double hash of unsigned_transaction does not match payload_to_sign"}
    end
  end

  def encode_message(nil) do
    nil
  end

  def encode_message(contents: contents, private_key: private_key, address: address) do
    encode_message(contents, private_key, address)
  end

  def encode_message(contents: contents) do
    encode_message(contents)
  end

  def encode_message(message) do
    message
    |> Base.encode16()
    |> String.replace_prefix("", "0000")
  end

  def encode_message(_message, _private_key_hex, _address) do
    _message = "Hey Bob, this is Alice, you and I can read this message, but no one else."
    private_key_hex = "8ef36a3c732f65deeb5c2ee59aaa90d3571c0149c63fe97ad4ed971155804947"
    address = "rdx1qspvvprlj3q76ltdxpz5qm54cp7dshrh3e9cemeu5746czdet3cfaegp8alwf"
    {:ok, public_key_hex} = Keys.address_to_public_key(address)
    IO.inspect(public_key_hex, label: "public key: ")
    {:ok, public_key_binary} = decode_data(public_key_hex)
    public_keypair = Curvy.Key.from_pubkey(public_key_binary)
    {:ok, private_key_secret} = Keys.private_key_to_secret(private_key_hex)
    dh = Curvy.Point.mul(public_keypair.point, private_key_secret)
    IO.inspect(dh.x, label: "dh x: ")
    IO.inspect(dh.y, label: "dh y: ")
    ephemeral_private_key_hex = "b1392c49f676fd48fcb206f2b1233cb1fc88c38321383f4acd6b4293539d036c"

    ephemeral_keypair =
      Curvy.Key.from_privkey(Base.decode16!(ephemeral_private_key_hex, case: :mixed))

    ephemeral_public_key = Curvy.Key.to_pubkey(ephemeral_keypair)
    IO.inspect(Base.encode16(ephemeral_public_key, case: :lower), label: "ephemeral public key: ")
    IO.inspect(ephemeral_keypair.point.x, label: "ephemeral point x: ")
    IO.inspect(ephemeral_keypair.point.y, label: "ephemeral point y: ")
    shared_secret_point = Curvy.Point.add(ephemeral_keypair.point, dh)
    shared_secret_integer = shared_secret_point.x
    IO.inspect(shared_secret_integer, label: "shared secret integer: ")
    shared_secret = :binary.encode_unsigned(shared_secret_integer, :big)
    IO.inspect(encode_data(shared_secret), label: "shared secret: ")
    nonce_bytes = :crypto.strong_rand_bytes(12)
    IO.inspect(Base.encode16(nonce_bytes), label: "nonce: ")
    salt = :crypto.hash(:sha256, nonce_bytes)
    IO.inspect(Base.encode16(salt), label: "salt: ")
    :scrypt.scrypt(shared_secret, salt, 32, 8192, 8, 32) |> encode_data()
  end

  def decode_message(nil) do
    nil
  end

  def decode_message(contents: contents, encrypted: encrypted) do
    decode_message(contents, encrypted)
  end

  def decode_message(contents: contents) do
    decode_message(contents, false)
  end

  # def decode_message(message, true = _encrypted) do
  ## TODO
  # end

  def decode_message("0000" <> message, false = _encrypted) do
    decode_data(message)
  end

  def decode_message("30303030" <> message, false = _encrypted) do
    with {:ok, result} <- decode_data(message),
         {:ok, result} <- decode_data(result) do
      {:ok, result}
    end
  end

  def decode_data(data_hex) do
    with {:ok, result} <- Base.decode16(data_hex, case: :mixed) do
      {:ok, result}
    else
      error ->
        {:error, error}
    end
  end

  def encode_data(data) do
    Base.encode16(data, case: :lower)
  end

  def maybe_put(map, _key, nil), do: map
  def maybe_put(map, key, value), do: Map.put(map, key, value)
end

# Radixir.Utils.encode_message(
#   "asd",
#   "8ef36a3c732f65deeb5c2ee59aaa90d3571c0149c63fe97ad4ed971155804947",
#   "rdx1qspvvprlj3q76ltdxpz5qm54cp7dshrh3e9cemeu5746czdet3cfaegp8alwf"
# )
