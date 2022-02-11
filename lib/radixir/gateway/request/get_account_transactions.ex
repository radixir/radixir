defmodule Radixir.Gateway.Request.GetAccountTransactions do
  alias Radixir.StitchPlan

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
  defdelegate account_identifier(stitch_plans, params), to: StitchPlan
  defdelegate at_state_identifier(stitch_plans, params), to: StitchPlan
  defdelegate cursor(stitch_plans, params), to: StitchPlan
  defdelegate limit(stitch_plans, params), to: StitchPlan
end
