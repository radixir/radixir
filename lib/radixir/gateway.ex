defmodule Radixir.Gateway do
  alias Radixir.GatewayAPI
  alias Radixir.Config
  alias Radixir.Schema
  alias Radixir.Shapes

  def get_info(url \\ Config.radix_gateway_api_url()) do
    GatewayAPI.get_info(url)
  end

  def derive_account_identifier(url \\ Config.radix_gateway_api_url(), params) do
    with {:ok, params} <- NimbleOptions.validate(params, Schema.derive_account_identifier()) do
      network_identifier =
        Keyword.get(params, :network_identifier)
        |> Keyword.get(:network)
        |> Shapes.network_identifier()

      public_key =
        Keyword.get(params, :public_key)
        |> Keyword.get(:hex)
        |> Shapes.public_key()

      body = Map.merge(network_identifier, public_key)
      GatewayAPI.derive_account_identifier(url, body)
    end
  end

  def get_account_balances(url \\ Config.radix_gateway_api_url(), params) do
    with {:ok, params} <- NimbleOptions.validate(params, Schema.get_account_balances()) do
      network_identifier =
        Keyword.get(params, :network_identifier)
        |> Keyword.get(:network)
        |> Shapes.network_identifier()

      account_identifier =
        Keyword.get(params, :account_identifier)
        |> Keyword.get(:address)
        |> Shapes.public_key()

      at_state_identifier =
        Keyword.get(params, :at_state_identifier)
        |> Shapes.at_state_identifier()

      body =
        network_identifier
        |> Map.merge(account_identifier)
        |> Map.merge(at_state_identifier)

      GatewayAPI.derive_account_identifier(url, body)
    end
  end
end
