defmodule Radixir do
  alias Radixir.HTTP
  alias Radixir.Keypair

  def send_xrd(from, to, amount) do
    with {:ok, %{private_key: private_key}} <- Keypair.get(from) do
      {:ok, _, %{"rri" => rri}} = get_native_token()

      actions = [
        %{
          amount: amount,
          from: from,
          rri: rri,
          to: to,
          type: "TokenTransfer"
        }
      ]

      {:ok, _, %{"transaction" => %{"blob" => blob, "hashOfBlobToSign" => hash_of_blob_to_sign}}} =
        build_transaction(actions, from)

      signature_der = Keypair.sign(hash_of_blob_to_sign, private_key)
      %{public_key: public_key_of_signer} = Keypair.from_private_key(private_key)
      finalize_transaction(blob, signature_der, public_key_of_signer, true)
    end
  end

  def get_native_token(id \\ nil) do
    HTTP.post("/archive", "tokens.get_native_token", %{}, id)
  end

  def get_token_info(rri, id \\ nil) do
    HTTP.post("/archive", "tokens.get_info", %{rri: rri}, id)
  end

  def get_next_epoch_validator_set(size, cursor, id \\ nil) do
    HTTP.post("/archive", "validators.get_next_epoch_set", %{size: size, cursor: cursor}, id)
  end

  def lookup_validator(address, id \\ nil) do
    HTTP.post("/archive", "validators.lookup_validator", %{validatorAddress: address}, id)
  end

  def lookup_transaction(transaction_id, id \\ nil) do
    HTTP.post("/archive", "transactions.lookup_transaction", %{txID: transaction_id}, id)
  end

  def get_transaction_status(transaction_id, id \\ nil) do
    HTTP.post("/archive", "transactions.get_transaction_status", %{txID: transaction_id}, id)
  end

  def get_token_balances(address, id \\ nil) do
    HTTP.post("/archive", "account.get_balances", %{address: address}, id)
  end

  def get_transaction_history(address, size, cursor, id \\ nil) do
    HTTP.post(
      "/archive",
      "account.get_transaction_history",
      %{address: address, size: size, cursor: cursor},
      id
    )
  end

  def get_stake_positions(address, id \\ nil) do
    HTTP.post("/archive", "account.get_stake_positions", %{address: address}, id)
  end

  def get_unstake_positions(address, id \\ nil) do
    HTTP.post("/archive", "account.get_unstake_positions", %{address: address}, id)
  end

  def get_network_id(id \\ nil) do
    HTTP.post("/archive", "network.get_id", %{}, id)
  end

  def get_transaction_demand(id \\ nil) do
    HTTP.post("/archive", "network.get_demand", %{}, id)
  end

  def get_network_throughput(id \\ nil) do
    HTTP.post("/archive", "network.get_throughput", %{}, id)
  end

  def get_account_info(id \\ nil) do
    HTTP.post("/account", "account.get_info", %{}, id)
  end

  def submit_transaction_single_step(actions, id \\ nil) do
    HTTP.post("/account", "account.submit_transaction_single_step", %{actions: actions}, id)
  end

  def build_transaction(actions, fee_payer, id \\ nil) do
    HTTP.post(
      "/construction",
      "construction.build_transaction",
      %{actions: actions, feePayer: fee_payer},
      id
    )
  end

  def finalize_transaction(blob, signature_der, public_key_of_signer, immediate_submit, id \\ nil) do
    HTTP.post(
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
      "/construction",
      "construction.submit_transaction",
      %{
        blob: blob,
        txID: transaction_id
      },
      id
    )
  end

  def get_api_configuration(id \\ nil) do
    HTTP.post("/system", "api.get_configuration", %{}, id)
  end

  def get_api_data(id \\ nil) do
    HTTP.post("/system", "api.get_data", %{}, id)
  end

  def get_bft_configuration(id \\ nil) do
    HTTP.post("/system", "bft.get_configuration", %{}, id)
  end

  def get_bft_data(id \\ nil) do
    HTTP.post("/system", "bft.get_data", %{}, id)
  end

  def get_mempool_configuration(id \\ nil) do
    HTTP.post("/system", "mempool.get_configuration", %{}, id)
  end

  def get_mempool_data(id \\ nil) do
    HTTP.post("/system", "mempool.get_data", %{}, id)
  end

  def get_latest_ledger_proof(id \\ nil) do
    HTTP.post("/system", "ledger.get_latest_proof", %{}, id)
  end

  def get_latest_ledger_epoch_proof(id \\ nil) do
    HTTP.post("/system", "ledger.get_latest_epoch_proof", %{}, id)
  end

  def get_radix_engine_configuration(id \\ nil) do
    HTTP.post("/system", "radix_engine.get_configuration", %{}, id)
  end

  def get_radix_engine_data(id \\ nil) do
    HTTP.post("/system", "radix_engine.get_data", %{}, id)
  end

  def get_sync_configuration(id \\ nil) do
    HTTP.post("/system", "sync.get_configuration", %{}, id)
  end

  def get_sync_data(id \\ nil) do
    HTTP.post("/system", "sync.get_data", %{}, id)
  end

  def get_networking_configuration(id \\ nil) do
    HTTP.post("/system", "networking.get_configuration", %{}, id)
  end

  def get_networking_data(id \\ nil) do
    HTTP.post("/system", "networking.get_data", %{}, id)
  end

  def get_networking_peers(id \\ nil) do
    HTTP.post("/system", "networking.get_peers", %{}, id)
  end

  def get_checkpoints(id \\ nil) do
    HTTP.post("/system", "checkpoints.get_checkpoints", %{}, id)
  end

  def get_node_info(id \\ nil) do
    HTTP.post("/validation", "validation.get_node_info", %{}, id)
  end

  def get_current_epoch_data(id \\ nil) do
    HTTP.post("/validation", "validation.get_current_epoch_data", %{}, id)
  end

  def get_node_health() do
    HTTP.get("/health")
  end

  def get_node_version() do
    HTTP.get("/version")
  end

  def get_node_metrics() do
    HTTP.get("/metrics")
  end
end
