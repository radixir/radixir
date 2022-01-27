defmodule Radixir.Utils do
  def double_hash(data) do
    result = :crypto.hash(:sha256, data)
    :crypto.hash(:sha256, result)
  end

  def verify_hash(unsigned_transaction, payload_to_sign) do
    {:ok, binary_unsigned_transaction} = Curvy.Util.decode(unsigned_transaction, :hex)

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

  def encode_message(contents: contents, encrypted: encrypted) do
    encode_message(contents, encrypted)
  end

  def encode_message(contents: contents) do
    encode_message(contents, false)
  end

  # def encode_message(message, true = _encrypted) do
  #   # TODO
  # end

  def encode_message(message, false = _encrypted) do
    message
    |> Base.encode16()
    |> String.replace_prefix("", "0000")
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
    Base.decode16!(message)
  end

  def decode_message("30303030" <> message, false = _encrypted) do
    message
    |> Base.decode16!()
    |> Base.decode16!()
  end

  def maybe_put(map, _key, nil), do: map
  def maybe_put(map, key, value), do: Map.put(map, key, value)
end
