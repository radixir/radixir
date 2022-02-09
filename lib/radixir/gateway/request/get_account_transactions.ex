defmodule Radixir.Gateway.Request.GetAccountTransactions do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params), to: RequestPiece
  defdelegate account_identifier(stitch_plans, params), to: RequestPiece
  defdelegate at_state_identifier(stitch_plans, params), to: RequestPiece
  defdelegate cursor(stitch_plans, params), to: RequestPiece
  defdelegate limit(stitch_plans, params), to: RequestPiece
end