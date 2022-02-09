defmodule Radixir.Core.Request.GetNetworkStatus do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params), to: RequestPiece
end
