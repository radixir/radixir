defmodule Radixir do
  # alias Radixir.GatewayAPI
  # alias Radixir.Keypair
  # alias Radixir.Utils

  # def send_xrd(from, to, amount, private_key) do
  #   with {:ok, %{private_key: private_key, public_key: public_key_of_signer}} <-
  #          Keypair.from_private_key(private_key),
  #        {:ok, %{"rri" => rri}} <- GatewayAPI.get_native_token(),
  #        actions <- [
  #          %{
  #            amount: amount,
  #            from: from,
  #            rri: rri,
  #            to: to,
  #            type: "TokenTransfer"
  #          }
  #        ],
  #        {:ok, %{"transaction" => %{"blob" => blob, "hashOfBlobToSign" => hash_of_blob_to_sign}}} <-
  #          GatewayAPI.build_transaction(actions, from),
  #        :ok <- Utils.verify_blob_hash(blob, hash_of_blob_to_sign) do
  #     signature_der = Keypair.sign_data(hash_of_blob_to_sign, private_key)
  #     GatewayAPI.finalize_transaction(blob, signature_der, public_key_of_signer, true)
  #   end
  # end
end
