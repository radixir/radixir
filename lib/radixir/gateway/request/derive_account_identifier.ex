defmodule Radixir.Gateway.Request.DeriveAccountIdentifier do
  alias Radixir.StitchPlan
  alias Radixir.Schema.Gateway
  alias Radixir.Util

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
  defdelegate public_key(stitch_plans, params), to: StitchPlan
end
