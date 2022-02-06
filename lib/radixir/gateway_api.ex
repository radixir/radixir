defmodule Radixir.GatewayAPI do
  alias Radixir.HTTP

  def get_info(url) do
    HTTP.post(url, "/gateway", %{})
  end

  def derive_account_identifier(url, body, options \\ []) do
    HTTP.post(url, "/account/derive", body, options)
  end

  def get_account_balances(url, body, options \\ []) do
    HTTP.post(url, "/account/balances", body, options)
  end

  def get_stake_positions(url, body, options \\ []) do
    HTTP.post(url, "/account/stakes", body, options)
  end

  def get_unstake_positions(url, body, options \\ []) do
    HTTP.post(url, "/account/unstakes", body, options)
  end

  def get_account_transactions(url, body, options \\ []) do
    HTTP.post(url, "/account/transactions", body, options)
  end

  def get_native_token_info(url, body, options \\ []) do
    HTTP.post(url, "/token/native", body, options)
  end

  def get_token_info(url, body, options \\ []) do
    HTTP.post(url, "/token", body, options)
  end

  def derive_token_identifier(url, body, options \\ []) do
    HTTP.post(url, "/token/derive", body, options)
  end

  def get_validator(url, body, options \\ []) do
    HTTP.post(url, "/validator", body, options)
  end

  def derive_validator_identifier(url, body, options \\ []) do
    HTTP.post(url, "/validator/derive", body, options)
  end

  def get_validators(url, body, options \\ []) do
    HTTP.post(url, "/validators", body, options)
  end

  def get_transaction_rules(url, body, options \\ []) do
    HTTP.post(url, "/transaction/rules", body, options)
  end

  def build_transaction(url, body, options \\ []) do
    HTTP.post(url, "/transaction/build", body, options)
  end

  def finalize_transaction(url, body, options \\ []) do
    HTTP.post(url, "/transaction/finalize", body, options)
  end

  def submit_transaction(url, body, options \\ []) do
    HTTP.post(url, "/transaction/submit", body, options)
  end

  def get_transaction_status(url, body, options \\ []) do
    HTTP.post(url, "/transaction/status", body, options)
  end
end
