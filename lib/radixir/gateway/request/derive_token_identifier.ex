defmodule Radixir.Gateway.Request.DeriveTokenIdentifier do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params \\ []), to: RequestPiece
  defdelegate public_key(stitch_plans, params), to: RequestPiece
  defdelegate symbol(stitch_plans, params), to: RequestPiece
end
