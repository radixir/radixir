defmodule Radixir.Core.Request.FinalizeTransaction do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params), to: RequestPiece
  defdelegate unsigned_transaction(stitch_plans, params), to: RequestPiece
  defdelegate signature(stitch_plans, params), to: RequestPiece
end
