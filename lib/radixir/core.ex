defmodule Radixir.Core do
  @moduledoc """
  Provides high level interaction with the Core API.
  """

  alias Radixir.Core.API
  alias Radixir.Core.Request
  alias Radixir.Key
  alias Radixir.Util

  @type public_key :: String.t()
  @type private_key :: String.t()
  @type address :: String.t()
  @type rri :: String.t()
  @type symbol :: String.t()
  @type options :: keyword()
  @type error_message :: String.t()
  @type unsigned_transaction :: String.t()
  @type signed_transaction :: String.t()
  @type signature_bytes :: String.t()
  @type signature_public_key :: String.t()
  @type transaction_hash :: String.t()
  @type fee_payer_address :: String.t()
  @type validator_address :: String.t()

  @doc """
  Gets network configuration.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_network_configuration(options) :: {:ok, map} | {:error, map | error_message}
  def get_network_configuration(options \\ []) do
    API.get_network_configuration(Keyword.get(options, :api, []))
  end

  @doc """
  Submits request to `/network/status`.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_network_status(options) :: {:ok, map} | {:error, map | error_message}
  def get_network_status(options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.GetNetworkStatus.network_identifier(network)
      |> Util.stitch()

    API.get_network_status(body, Keyword.get(options, :api, []))
  end
end
