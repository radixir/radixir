defmodule Radixir.Core.Request.ParseTransaction do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params), to: RequestPiece
  defdelegate transaction(stitch_plans, params), to: RequestPiece
  defdelegate signed(stitch_plans, params), to: RequestPiece
end
