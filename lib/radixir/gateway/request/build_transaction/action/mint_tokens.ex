defmodule Radixir.Gateway.Action.MintTokens do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, type: "MintTokens")
  end

  defdelegate to_account(stitch_plans, params), to: StitchPlan

  defdelegate amount(stitch_plans, params), to: StitchPlan

  def token_identifier(stitch_plans, params) do
    StitchPlan.token_identifier(stitch_plans, params, [:amount])
  end
end
