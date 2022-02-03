defmodule Radixir.Gateway do
  alias Radixir.GatewayAPI
  alias Radixir.Config

  def get_info(url \\ Config.radix_gateway_api_url()) do
    GatewayAPI.get_info(url)
  end

  def derive_account_identifier(url \\ Config.radix_gateway_api_url(), params) do
    GatewayAPI.derive_account_identifier(url, params)
  end
end
