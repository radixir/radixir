defmodule Radixir.Core.Request.GetMempoolTransaction do
  alias Radixir.StitchPlan

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
  defdelegate transaction_identifier(stitch_plans, params), to: StitchPlan
end
