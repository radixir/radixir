defmodule Radixir.Utils do
  alias Radixir.Keys

  def hash(data), do: :crypto.hash(:sha256, data)

  def verify_hash(unsigned_transaction, payload_to_sign) do
    with {:ok, binary_unsigned_transaction} <-
           decode16(unsigned_transaction, "unsigned_transaction") do
      double_hash_hex =
        binary_unsigned_transaction
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

  def encode_message(nil), do: nil

  def encode_message(
        contents: contents,
        private_key_hex: private_key_hex,
        radix_address: radix_address
      ),
      do: encode_message(contents, private_key_hex, radix_address)

  def encode_message(contents: contents), do: encode_message(contents)

  def encode_message(message) do
    message
    |> Base.encode16()
    |> String.replace_prefix("", "0000")
  end

  def encode_message(message, private_key_hex, radix_address) do
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

  def decode_message(nil), do: nil

  def decode_message(
        contents: contents,
        private_key_hex: private_key_hex,
        radix_address: radix_address
      ),
      do: decode_message(contents, private_key_hex, radix_address)

  def decode_message(contents: contents), do: decode_message(contents)

  def decode_message("0000" <> message), do: decode16(message, "message")

  def decode_message("30303030" <> message) do
    with {:ok, result} <- decode16(message, "message"),
         {:ok, result} <- decode16(result, "message") do
      {:ok, result}
    end
  end

  def decode_message(message, private_key_hex, radix_address) do
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

  def maybe_put(map, _key, nil), do: map
  def maybe_put(map, key, value), do: Map.put(map, key, value)

  defp get_dh(private_key_hex, radix_address) do
    with {:ok, private_key_secret} <- Keys.private_key_to_secret(private_key_hex),
         {:ok, public_key_hex} <- Keys.address_to_public_key(radix_address),
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
