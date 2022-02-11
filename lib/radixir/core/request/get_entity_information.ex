defmodule Radixir.Core.Request.GetEntityInformation do
  alias Radixir.StitchPlan

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan

  defdelegate entity_identifier(stitch_plans, params), to: StitchPlan

  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:entity_identifer])
  end
end
