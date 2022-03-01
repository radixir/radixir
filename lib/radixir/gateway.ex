defmodule Radixir.Gateway do
  alias Radixir.Gateway.API
  alias Radixir.Gateway.Request
  alias Radixir.Util

  @type public_key :: String.t()
  @type address :: String.t()
  @type options :: keyword()

  @doc """
  Gets the Gateway API version, network and current ledger state.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
  """
  def get_info(options \\ []) do
    API.get_info(options)
  end

  @doc """
  Gets the account address associated with the given public key.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec derive_account_identifier(public_key, options) ::
          {:ok, map()} | {:error, map | String.t()}
  def derive_account_identifier(public_key, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    body =
      []
      |> Request.DeriveAccountIdentifier.network_identifier(network)
      |> Request.DeriveAccountIdentifier.public_key(hex: public_key)
      |> Util.stitch()

    API.derive_account_identifier(body, options)
  end

  @doc """
  Gets an account's available and staked token balances.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_account_balances(address, options) ::
          {:ok, map()} | {:error, map | String.t()}
  def get_account_balances(address, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetAccountBalances.network_identifier(network)
      |> Request.GetAccountBalances.account_identifier(address: address)
      |> Request.GetAccountBalances.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_account_balances(body, options)
  end
end

# Radixir.Gateway.get_account_balances("tdx1qspf8f3eeg06955d5pzgvntz36c6nych7f8jw68mdmhlzvflj7pylqs9qzh0z", network: "stokenet", headers: ["X-Radixdlt-Target-Gw-Api": "1.0.2"], url: "https://stokenet.radixdlt.com")
