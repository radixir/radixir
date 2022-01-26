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

  def maybe_put(map, _key, nil), do: map
  def maybe_put(map, key, value), do: Map.put(map, key, value)
end
