defmodule Radixir.Core.Request.GetCommittedTransactions do
  alias Radixir.StitchPlan

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
  defdelegate state_identifier(stitch_plans, params), to: StitchPlan
  defdelegate limit(stitch_plans, params), to: StitchPlan
end
