defmodule Radixir.Core.Request.GetEntityInformation do
  alias Radixir.RequestPiece

  defdelegate network_identifier(stitch_plans, params \\ []), to: RequestPiece

  defdelegate entity_identifier(stitch_plans, params), to: RequestPiece

  def sub_entity(stitch_plans, params) do
    RequestPiece.sub_entity(stitch_plans, params, [:entity_identifer])
  end
end
