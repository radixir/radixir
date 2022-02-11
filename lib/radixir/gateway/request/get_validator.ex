defmodule Radixir.Gateway.Request.GetValidator do
  alias Radixir.StitchPlan

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
  defdelegate validator_identifier(stitch_plans, params), to: StitchPlan
  defdelegate at_state_identifier(stitch_plans, params), to: StitchPlan
end
