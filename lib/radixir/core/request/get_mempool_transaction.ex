defmodule Radixir.Core.Request.GetMempoolTransaction do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params), to: RequestPiece
  defdelegate transaction_identifier(stitch_plans, params), to: RequestPiece
end
