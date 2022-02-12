defmodule Examples.Gateway.BuildTransaction.CreateToken do
  alias Radixir.Gateway.API
  alias Radixir.Gateway.Request.BuildTransaction
  alias Radixir.Gateway.Request.BuildTransaction.Action.CreateToken
  alias Radixir.Util

  def go() do
    creator = "tdx1qspf8f3eeg06955d5pzgvntz36c6nych7f8jw68mdmhlzvflj7pylqs9qzh0z"
    token_supply = "0"
    token_granularity = "1"
    token_identifier = "jec_tr1qvnc03t4m6te6zlkcy03q4sst5ddcad49urt6ggr7lvq6he0sq"

    request_body =
      []
      |> BuildTransaction.network_identifier(network: "stokenet")
      |> BuildTransaction.fee_payer(address: creator)
      |> Util.stitch()

    action =
      []
      |> CreateToken.type()
      |> CreateToken.token_properties(
        name: "JEC Token",
        description: "jec tokens ftw",
        icon_url: "https://me.me/icon",
        url: "https://me.me",
        symbol: "jec",
        is_supply_mutable: true,
        granularity: token_granularity
      )
      |> CreateToken.owner(address: creator)
      |> CreateToken.token_supply(value: token_supply)
      |> CreateToken.token_identifier(rri: token_identifier)
      |> CreateToken.to_account(address: creator)
      |> Util.stitch()

    actions = [action]

    request_body = BuildTransaction.add_actions(request_body, actions)

    API.build_transaction(request_body,
      url: "https://stokenet.radixdlt.com",
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.2"]
    )
  end
end
