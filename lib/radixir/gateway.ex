defmodule Radixir.Gateway do
  alias Radixir.GatewayAPI
  alias Radixir.Keypair
  alias Radixir.Utils

  def transfer_tokens(from, to, amount, rri, private_key) do
    with {:ok, %{private_key: private_key, public_key: public_key}} <-
           Keypair.from_private_key(private_key),
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
         :ok <- Utils.verify_hash(unsigned_transaction, payload_to_sign) do
      signature_bytes = Keypair.sign_data(payload_to_sign, private_key)
      GatewayAPI.finalize_transaction(unsigned_transaction, signature_bytes, public_key, true)
    end
  end

  def transfer_xrd(from, to, amount, private_key) do
    with {:ok, %{"token" => %{"token_identifier" => %{"rri" => rri}}}} <-
           GatewayAPI.get_native_token_info() do
      transfer_tokens(from, to, amount, rri, private_key)
    end
  end

  def build_create_tokens_action() do
  end

  def build_transfer_tokens_action() do
  end

  def build_stake_tokens_action() do
  end

  def build_unstake_tokens_action() do
  end

  def build_mint_tokens_action() do
  end

  def build_burn_tokens_action() do
  end
end
