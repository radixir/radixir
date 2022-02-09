defmodule Radixir.Core.Request.SignTransaction do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params \\ []), to: RequestPiece
  defdelegate unsigned_transaction(stitch_plans, params), to: RequestPiece
  defdelegate public_key(stitch_plans, params), to: RequestPiece
end
