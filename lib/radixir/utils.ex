defmodule Radixir.Utils do
  def double_hash(data) do
    result = :crypto.hash(:sha256, data)
    :crypto.hash(:sha256, result)
  end

  def verify_blob_hash(blob, hash_of_blob_to_sign) do
    {:ok, binary_blob} = Curvy.Util.decode(blob, :hex)

    double_hash_hex =
      binary_blob
      |> double_hash()
      |> Curvy.Util.encode(:hex)

    if double_hash_hex == hash_of_blob_to_sign do
      :ok
    else
      {:error, "double hash of blob does not match hashOfBlobToSign"}
    end
  end
end
