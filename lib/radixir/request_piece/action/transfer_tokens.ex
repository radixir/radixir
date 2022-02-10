defmodule Radixir.RequestPiece.Action.TransferTokens do
  alias Radixir.RequestPiece

  def type(stitch_plans, prefix_keys \\ []) do
    RequestPiece.type(stitch_plans, [type: "TransferTokens"], prefix_keys)
  end

  defdelegate from_account(stitch_plans, params), to: RequestPiece
  defdelegate to_account(stitch_plans, params), to: RequestPiece

  def amount(stitch_plans, params, prefix_keys \\ []) do
    RequestPiece.amount(stitch_plans, params, prefix_keys)
  end

  def to(stitch_plans, params, prefix_keys \\ []) do
    RequestPiece.to(stitch_plans, params, prefix_keys)
  end

  def from(stitch_plans, params, prefix_keys \\ []) do
    RequestPiece.from(stitch_plans, params, prefix_keys)
  end

  def token_identifier(stitch_plans, params) do
    RequestPiece.token_identifier(stitch_plans, params, [:amount])
  end
end
