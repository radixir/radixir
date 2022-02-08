defmodule Radixir do
  alias Radixir.Gateway
  alias Radixir.Gateway.CreateToken
  alias Radixir.Util

  def get_account_balances() do
    []
    |> Gateway.network_identifier(network: "mainnet")
    |> Gateway.account_identifier(address: "sdfdf")
    |> Gateway.at_state_identifier(version: 45)
    |> Util.stitch()
  end

  def create_token() do
    body =
      []
      |> Gateway.network_identifier(network: "mainnet")
      |> Gateway.fee_payer(address: "lkjhldkhakjshdkjahlsdf")
      |> Util.stitch()

    create_token_action_1 =
      []
      |> CreateToken.token_properties(
        name: "JEC",
        description: "the jec coin rocks",
        icon_url: "here.com",
        url: "there.com",
        symbol: "jec",
        is_supply_mutable: true,
        granularity: "343"
      )
      |> CreateToken.owner(address: "ownder address")
      |> CreateToken.token_supply(value: "34343434")
      |> CreateToken.token_identifier(rri: "sdsdfsdfsdsfs")
      |> CreateToken.to_account(address: "to account address")
      |> Util.stitch()

    create_token_action_2 =
      []
      |> CreateToken.token_properties(
        name: "JEC",
        description: "the jec coin rocks",
        icon_url: "here.com",
        url: "there.com",
        symbol: "jec",
        is_supply_mutable: true,
        granularity: "343"
      )
      |> CreateToken.owner(address: "ownder address")
      |> CreateToken.token_supply(value: "34343434")
      |> CreateToken.token_identifier(rri: "sdsdfsdfsdsfs")
      |> CreateToken.to_account(address: "to account address")
      |> Util.stitch()

    actions = [create_token_action_1, create_token_action_2]

    Util.add_actions(body, actions)
  end
end
