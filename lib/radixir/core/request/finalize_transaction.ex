defmodule Radixir.Core.Request.FinalizeTransaction do
  alias Radixir.StitchPlan

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
  defdelegate unsigned_transaction(stitch_plans, params), to: StitchPlan
  defdelegate signature(stitch_plans, params), to: StitchPlan
end
