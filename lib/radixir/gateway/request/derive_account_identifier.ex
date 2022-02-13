defmodule Radixir.Gateway.Request.DeriveAccountIdentifier do
  alias Radixir.StitchPlan

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
  defdelegate public_key(stitch_plans, params), to: StitchPlan
end
