defmodule Radixir.GatewayAPI do
  alias Radixir.HTTP

  def get_info(url) do
    HTTP.post(url, "/gateway", %{})
  end

  def derive_account_identifier(url, body) do
    HTTP.post(url, "/account/derive", body)
  end

  def get_account_balances(url, body) do
    HTTP.post(url, "/account/balances", body)
  end

  def get_stake_positions(url, body) do
    HTTP.post(url, "/account/stakes", body)
  end

  def get_unstake_positions(url, body) do
    HTTP.post(url, "/account/unstakes", body)
  end

  def get_account_transactions(url, body) do
    HTTP.post(url, "/account/transactions", body)
  end

  def get_native_token_info(url, body) do
    HTTP.post(url, "/token/native", body)
  end

  def get_token_info(url, body) do
    HTTP.post(url, "/token", body)
  end

  def derive_token_identifier(url, body) do
    HTTP.post(url, "/token/derive", body)
  end

  def get_validator(url, body) do
    HTTP.post(url, "/validator", body)
  end

  def derive_validator_identifier(url, body) do
    HTTP.post(url, "/validator/derive", body)
  end

  def get_validators(url, body) do
    HTTP.post(url, "/validators", body)
  end

  def get_transaction_rules(url, body) do
    HTTP.post(url, "/transaction/rules", body)
  end

  def build_transaction(url, body) do
    HTTP.post(url, "/transaction/build", body)
  end

  def finalize_transaction(url, body) do
    HTTP.post(url, "/transaction/finalize", body)
  end

  def submit_transaction(url, body) do
    HTTP.post(url, "/transaction/submit", body)
  end

  def get_transaction_status(url, body) do
    HTTP.post(url, "/transaction/status", body)
  end
end
