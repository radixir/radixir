defmodule Radixir.Utils do
  alias Radixir.Keys

  def double_hash(data) do
    result = :crypto.hash(:sha256, data)
    :crypto.hash(:sha256, result)
  end

  def verify_hash(unsigned_transaction, payload_to_sign) do
    binary_unsigned_transaction = decode16(unsigned_transaction)

    double_hash_hex =
      binary_unsigned_transaction
      |> double_hash()
      |> encode16()

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
    with {:ok, dh} <- get_dh(private_key_hex, address),
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
    decode16(message)
  end

  def decode_message("30303030" <> message) do
    with {:ok, result} <- decode16(message),
         {:ok, result} <- decode16(result) do
      {:ok, result}
    end
  end

  def decode_message(message, private_key_hex, address) do
    with {:ok, dh} <- get_dh(private_key_hex, address),
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

  def decode16(data_hex, info \\ nil) do
    with {:ok, result} <- Base.decode16(data_hex, case: :mixed) do
      {:ok, result}
    else
      _ ->
        message = if info, do: "could not decode #{info}", else: "could not decode data"
        {:error, message}
    end
  end

  def encode16(data) do
    Base.encode16(data, case: :lower)
  end

  def maybe_put(map, _key, nil), do: map
  def maybe_put(map, key, value), do: Map.put(map, key, value)

  defp get_dh(private_key_hex, address) do
    with {:ok, private_key_secret} <- Keys.private_key_to_secret(private_key_hex),
         {:ok, public_key_hex} <- Keys.address_to_public_key(address),
         {:ok, public_key_binary} <- decode16(public_key_hex),
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
         {:ok, ephemeral_public_key_bytes} <- String.slice(message, 4..69) |> decode16(),
         ephemeral_keypair <- Curvy.Key.from_pubkey(ephemeral_public_key_bytes),
         {:ok, nonce_bytes} <- String.slice(message, 70..93) |> decode16(),
         {:ok, cipher_tag_bytes} <- String.slice(message, 94..125) |> decode16(),
         {:ok, cipher_text_bytes} <- String.slice(message, 126..-1) |> decode16() do
      shared_secret_point = Curvy.Point.add(ephemeral_keypair.point, dh)
      shared_secret_integer = shared_secret_point.x
      shared_secret_bytes = :binary.encode_unsigned(shared_secret_integer, :big)
      salt_bytes = :crypto.hash(:sha256, nonce_bytes)
      key_bytes = :scrypt.scrypt(shared_secret_bytes, salt_bytes, 32, 8192, 8, 32)
      {key_bytes, ephemeral_public_key_bytes, nonce_bytes, cipher_text_bytes, cipher_tag_bytes}
    end
  end
end
