defmodule Radixir.Gateway.Request.DeriveAccountIdentifier do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params \\ []), to: RequestPiece
  defdelegate public_key(stitch_plans, params), to: RequestPiece
end
