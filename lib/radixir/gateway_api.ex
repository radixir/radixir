defmodule Radixir.GatewayAPI do
  alias Radixir.Config
  alias Radixir.HTTP

  def get_gateway_info() do
    HTTP.post(Config.radix_gateway_api_url(), "/gateway", %{})
  end

  def derive_account_identifier(hex_public_key) do
    HTTP.post(Config.radix_gateway_api_url(), "/account/derive", %{
      network_identifier: %{
        network: Config.network()
      },
      public_key: %{
        hex: hex_public_key
      }
    })
  end

  def get_account_balances(address) do
    HTTP.post(Config.radix_gateway_api_url(), "/account/balances", %{
      network_identifier: %{
        network: Config.network()
      },
      account_identifier: %{
        address: address
      }
    })
  end

  def get_stake_positions(address) do
    HTTP.post(Config.radix_gateway_api_url(), "/account/stakes", %{
      network_identifier: %{
        network: Config.network()
      },
      account_identifier: %{
        address: address
      }
    })
  end

  def get_unstake_positions(address) do
    HTTP.post(Config.radix_gateway_api_url(), "/account/unstakes", %{
      network_identifier: %{
        network: Config.network()
      },
      account_identifier: %{
        address: address
      }
    })
  end

  def get_account_transactions(address, cursor, limit) do
    HTTP.post(Config.radix_gateway_api_url(), "/account/transactions", %{
      network_identifier: %{
        network: Config.network()
      },
      account_identifier: %{
        address: address
      },
      cursor: cursor,
      limit: limit
    })
  end
end
