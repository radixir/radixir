defmodule Radixir do
  alias Radixir.HTTP

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

  def health() do
    HTTP.get("/health")
  end

  def version() do
    HTTP.get("/version")
  end

  def metrics() do
    HTTP.get("/metrics")
  end
end
