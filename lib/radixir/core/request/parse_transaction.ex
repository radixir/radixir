defmodule Radixir.Core.Request.ParseTransaction do
  alias Radixir.StitchPlan

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
  defdelegate transaction(stitch_plans, params), to: StitchPlan
  defdelegate signed(stitch_plans, params), to: StitchPlan
end
