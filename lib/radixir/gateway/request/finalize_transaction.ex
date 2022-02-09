defmodule Radixir.Gateway.Request.FinalizeTransaction do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params \\ []), to: RequestPiece
  defdelegate unsigned_transaction(stitch_plans, params), to: RequestPiece
  defdelegate signature(stitch_plans, params), to: RequestPiece
  defdelegate submit(stitch_plans, params), to: RequestPiece
end
