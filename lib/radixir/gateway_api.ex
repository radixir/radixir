defmodule Radixir.GatewayAPI do
  alias Radixir.Config
  alias Radixir.HTTP

  def get_network_id(id \\ nil) do
    HTTP.post(Config.radix_gateway_api_url(), "/archive", "network.get_id", %{}, id)
  end

  def get_native_token(id \\ nil) do
    HTTP.post(Config.radix_gateway_api_url(), "/archive", "tokens.get_native_token", %{}, id)
  end

  def get_token_info(rri, id \\ nil) do
    HTTP.post(Config.radix_gateway_api_url(), "/archive", "tokens.get_info", %{rri: rri}, id)
  end

  def get_next_epoch_validator_set(size, cursor, id \\ nil) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/archive",
      "validators.get_next_epoch_set",
      %{size: size, cursor: cursor},
      id
    )
  end

  def lookup_validator(address, id \\ nil) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/archive",
      "validators.lookup_validator",
      %{validatorAddress: address},
      id
    )
  end

  def lookup_transaction(transaction_id, id \\ nil) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/archive",
      "transactions.lookup_transaction",
      %{txID: transaction_id},
      id
    )
  end

  def get_transaction_status(transaction_id, id \\ nil) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/archive",
      "transactions.get_transaction_status",
      %{txID: transaction_id},
      id
    )
  end

  def get_token_balances(address, id \\ nil) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/archive",
      "account.get_balances",
      %{address: address},
      id
    )
  end

  def get_transaction_history(address, size, cursor, id \\ nil) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/archive",
      "account.get_transaction_history",
      %{address: address, size: size, cursor: cursor},
      id
    )
  end

  def get_stake_positions(address, id \\ nil) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/archive",
      "account.get_stake_positions",
      %{address: address},
      id
    )
  end

  def get_unstake_positions(address, id \\ nil) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/archive",
      "account.get_unstake_positions",
      %{address: address},
      id
    )
  end

  def get_transaction_demand(id \\ nil) do
    HTTP.post(Config.radix_gateway_api_url(), "/archive", "network.get_demand", %{}, id)
  end

  def get_network_throughput(id \\ nil) do
    HTTP.post(Config.radix_gateway_api_url(), "/archive", "network.get_throughput", %{}, id)
  end

  def build_transaction(actions, fee_payer, id \\ nil) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/construction",
      "construction.build_transaction",
      %{actions: actions, feePayer: fee_payer},
      id
    )
  end

  def finalize_transaction(blob, signature_der, public_key_of_signer, immediate_submit, id \\ nil) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/construction",
      "construction.finalize_transaction",
      %{
        blob: blob,
        signatureDER: signature_der,
        publicKeyOfSigner: public_key_of_signer,
        immediateSubmit: immediate_submit
      },
      id
    )
  end

  def submit_transaction(blob, transaction_id, id \\ nil) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/construction",
      "construction.submit_transaction",
      %{
        blob: blob,
        txID: transaction_id
      },
      id
    )
  end
end
