defmodule Radixir.Gateway.Action.BurnTokens do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, type: "BurnTokens")
  end

  defdelegate from_account(stitch_plans, params), to: RequestPiece

  defdelegate amount(stitch_plans, params), to: RequestPiece

  def token_identifier(stitch_plans, params) do
    RequestPiece.token_identifier(stitch_plans, params, [:amount])
  end
end