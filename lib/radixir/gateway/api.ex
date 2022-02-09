defmodule Radixir.Gateway.API do
  alias Radixir.Util
  alias Radixir.HTTP

  def get_info(options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/gateway", %{}, options)
    end
  end

  def derive_account_identifier(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/account/derive", body, options)
    end
  end

  def get_account_balances(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/account/balances", body, options)
    end
  end

  def get_stake_positions(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/account/stakes", body, options)
    end
  end

  def get_unstake_positions(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/account/unstakes", body, options)
    end
  end

  def get_account_transactions(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/account/transactions", body, options)
    end
  end

  def get_native_token_info(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/token/native", body, options)
    end
  end

  def get_token_info(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/token", body, options)
    end
  end

  def derive_token_identifier(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/token/derive", body, options)
    end
  end

  def get_validator(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/validator", body, options)
    end
  end

  def derive_validator_identifier(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/validator/derive", body, options)
    end
  end

  def get_validators(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/validators", body, options)
    end
  end

  def get_transaction_rules(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/transaction/rules", body, options)
    end
  end

  def build_transaction(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/transaction/build", body, options)
    end
  end

  def finalize_transaction(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/transaction/finalize", body, options)
    end
  end

  def submit_transaction(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/transaction/submit", body, options)
    end
  end

  def get_transaction_status(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/transaction/status", body, options)
    end
  end
end
