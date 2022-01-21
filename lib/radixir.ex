defmodule Radixir do
  alias Radixir.GatewayAPI
  alias Radixir.Keypair
  alias Radixir.Utils

  def send_xrd(from, to, amount, private_key) do
    with {:ok, %{private_key: private_key, public_key: public_key}} <-
           Keypair.from_private_key(private_key),
         {:ok, %{"token" => %{"token_identifier" => %{"rri" => rri}}}} <-
           GatewayAPI.get_native_token_info(),
         actions <- [
           %{
             type: "TransferTokens",
             from_account: %{
               address: from
             },
             to_account: %{
               address: to
             },
             amount: %{
               token_identifier: %{
                 rri: rri
               },
               value: amount
             }
           }
         ],
         {:ok,
          %{
            "transaction_build" => %{
              "payload_to_sign" => payload_to_sign,
              "unsigned_transaction" => unsigned_transaction
            }
          }} <-
           GatewayAPI.build_transaction(actions, from),
         :ok <- Utils.verify_blob_hash(unsigned_transaction, payload_to_sign) do
      signature_bytes = Keypair.sign_data(payload_to_sign, private_key)
      GatewayAPI.finalize_transaction(unsigned_transaction, signature_bytes, public_key, true)
    end
  end
end
