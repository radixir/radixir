defmodule Radixir.Gateway.Request.GetNativeTokenInfo do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params \\ []), to: RequestPiece
  defdelegate at_state_identifier(stitch_plans, params), to: RequestPiece
end
