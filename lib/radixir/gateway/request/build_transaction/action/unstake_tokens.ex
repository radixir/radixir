defmodule Radixir.Gateway.Request.BuildTransaction.Action.UnstakeTokens do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, type: "UntakeTokens")
  end

  def from_validator(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:from_validator, :address], value: address]]

    stitch_plan ++ stitch_plans
  end

  defdelegate to_account(stitch_plans, params), to: StitchPlan

  defdelegate amount(stitch_plans, params), to: StitchPlan

  def token_identifier(stitch_plans, params) do
    StitchPlan.token_identifier(stitch_plans, params, [:amount])
  end

  def unstake_percentage(stitch_plans, params) do
    schema = [
      unstake_percentage: [
        type: :non_neg_integer,
        required: true
      ]
    ]

    unstake_percentage =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:unstake_percentage)

    stitch_plan = [[keys: [:unstake_percentage], value: unstake_percentage]]

    stitch_plan ++ stitch_plans
  end
end
