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

  def encode_message(contents: contents, private_key_hex: private_key_hex, address: address) do
    encode_message(contents, private_key_hex, address)
  end

  def encode_message(contents: contents) do
    encode_message(contents)
  end

  def encode_message(message) do
    message
    |> Base.encode16()
    |> String.replace_prefix("", "0000")
  end

  def encode_message(message, private_key_hex, address) do
    {:ok, public_key_hex} = Keys.address_to_public_key(address)
    {:ok, public_key_binary} = decode_data(public_key_hex)
    public_keypair = Curvy.Key.from_pubkey(public_key_binary)
    {:ok, private_key_secret} = Keys.private_key_to_secret(private_key_hex)
    dh = Curvy.Point.mul(public_keypair.point, private_key_secret)
    ephemeral_keypair = Curvy.generate_key()
    ephemeral_public_key = Curvy.Key.to_pubkey(ephemeral_keypair)
    shared_secret_point = Curvy.Point.add(ephemeral_keypair.point, dh)
    shared_secret_integer = shared_secret_point.x
    shared_secret = :binary.encode_unsigned(shared_secret_integer, :big)
    nonce_bytes = :crypto.strong_rand_bytes(12)
    salt = :crypto.hash(:sha256, nonce_bytes)
    key = :scrypt.scrypt(shared_secret, salt, 32, 8192, 8, 32)
    {:ok, {_ad, payload}} = ExCrypto.encrypt(key, ephemeral_public_key, nonce_bytes, message)
    {_iv, cipher_text, cipher_tag} = payload

    {:ok,
     (<<1>> <> <<255>> <> ephemeral_public_key <> nonce_bytes <> cipher_tag <> cipher_text)
     |> encode_data()}
  end

  def decode_message(nil) do
    nil
  end

  def decode_message(contents: contents, private_key_hex: private_key_hex, address: address) do
    decode_message(contents, private_key_hex, address)
  end

  def decode_message(contents: contents) do
    decode_message(contents)
  end

  def decode_message("0000" <> message) do
    decode_data(message)
  end

  def decode_message("30303030" <> message) do
    with {:ok, result} <- decode_data(message),
         {:ok, result} <- decode_data(result) do
      {:ok, result}
    end
  end

  def decode_message(message, private_key_hex, address) do
    {:ok, public_key_hex} = Keys.address_to_public_key(address)
    {:ok, public_key_binary} = decode_data(public_key_hex)
    public_keypair = Curvy.Key.from_pubkey(public_key_binary)
    {:ok, private_key_secret} = Keys.private_key_to_secret(private_key_hex)
    dh = Curvy.Point.mul(public_keypair.point, private_key_secret)

    ephemeral_public_key_hex = String.slice(message, 4..69)

    ephemeral_keypair =
      Curvy.Key.from_pubkey(Base.decode16!(ephemeral_public_key_hex, case: :mixed))

    ephemeral_public_key_bytes = Curvy.Key.to_pubkey(ephemeral_keypair)
    nonce = String.slice(message, 70..93)
    nonce_bytes = Base.decode16!(nonce, case: :mixed)
    cipher_tag = String.slice(message, 94..125)
    cipher_tag_bytes = Base.decode16!(cipher_tag, case: :mixed)
    cipher_text = String.slice(message, 126..-1)
    cipher_text_bytes = Base.decode16!(cipher_text, case: :mixed)
    shared_secret_point = Curvy.Point.add(ephemeral_keypair.point, dh)
    shared_secret_integer = shared_secret_point.x
    shared_secret = :binary.encode_unsigned(shared_secret_integer, :big)
    salt = :crypto.hash(:sha256, nonce_bytes)
    key = :scrypt.scrypt(shared_secret, salt, 32, 8192, 8, 32)

    ExCrypto.decrypt(
      key,
      ephemeral_public_key_bytes,
      nonce_bytes,
      cipher_text_bytes,
      cipher_tag_bytes
    )
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
