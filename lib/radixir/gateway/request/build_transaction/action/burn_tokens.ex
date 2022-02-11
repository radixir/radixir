defmodule Radixir.Gateway.Action.BurnTokens do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, type: "BurnTokens")
  end

  defdelegate from_account(stitch_plans, params), to: StitchPlan

  defdelegate amount(stitch_plans, params), to: StitchPlan

  def token_identifier(stitch_plans, params) do
    StitchPlan.token_identifier(stitch_plans, params, [:amount])
  end
end
