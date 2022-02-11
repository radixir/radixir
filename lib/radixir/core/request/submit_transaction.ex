defmodule Radixir.Core.Request.SubmitTransaction do
  alias Radixir.StitchPlan

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
  defdelegate signed_transaction(stitch_plans, params), to: StitchPlan
end
