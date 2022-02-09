defmodule Radixir.Gateway.Request.GetUnstakePositions do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params), to: RequestPiece
  defdelegate account_identifier(stitch_plans, params), to: RequestPiece
  defdelegate at_state_identifier(stitch_plans, params), to: RequestPiece
end
