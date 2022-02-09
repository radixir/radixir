defmodule Radixir.Core.Request.GetCommittedTransactions do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params), to: RequestPiece
  defdelegate state_identifier(stitch_plans, params), to: RequestPiece
  defdelegate limit(stitch_plans, params), to: RequestPiece
end
