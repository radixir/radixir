defmodule Radixir.Core.Request.GetTransactionHash do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params), to: RequestPiece
  defdelegate signed_transaction(stitch_plans, params), to: RequestPiece
end
