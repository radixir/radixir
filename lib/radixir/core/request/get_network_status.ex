defmodule Radixir.Core.Request.GetNetworkStatus do
  alias Radixir.StitchPlan

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
end
