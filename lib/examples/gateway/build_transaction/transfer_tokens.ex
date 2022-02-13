defmodule Examples.Gateway.BuildTransaction.TransferTokens do
  @moduledoc false

  alias Radixir.Gateway.API
  alias Radixir.Gateway.Request.BuildTransaction
  alias Radixir.Gateway.Request.BuildTransaction.Action.TransferTokens
  alias Radixir.Util

  def go() do
    from = "tdx1qspf8f3eeg06955d5pzgvntz36c6nych7f8jw68mdmhlzvflj7pylqs9qzh0z"
    to_1 = "tdx1qspa8jmwnd8se6u3qmpdljryets2mv3e5u8eh2cnwmz6jquh5c2zs8src9qxu"
    to_2 = "tdx1qspdnf997vu6tlzwggctnsf2jnepzq3ctzv77qszyeh8kr3wl99w03s4w2ev4"
    amount = "1000000000000000000"
    rri = "xrd_tr1qyf0x76s"

    request_body =
      []
      |> BuildTransaction.network_identifier(network: "stokenet")
      |> BuildTransaction.fee_payer(address: from)
      |> Util.stitch()

    action_1 =
      []
      |> TransferTokens.type()
      |> TransferTokens.from_account(address: from)
      |> TransferTokens.to_account(address: to_1)
      |> TransferTokens.amount(value: amount)
      |> TransferTokens.token_identifier(rri: rri)
      |> Util.stitch()

    action_2 =
      []
      |> TransferTokens.type()
      |> TransferTokens.from_account(address: from)
      |> TransferTokens.to_account(address: to_2)
      |> TransferTokens.amount(value: amount)
      |> TransferTokens.token_identifier(rri: rri)
      |> Util.stitch()

    actions = [action_1, action_2]

    request_body = BuildTransaction.add_actions(request_body, actions)

    API.build_transaction(request_body,
      url: "https://stokenet.radixdlt.com",
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.2"]
    )
  end
end
