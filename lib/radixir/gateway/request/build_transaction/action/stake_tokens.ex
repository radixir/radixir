defmodule Radixir.Gateway.Action.StakeTokens do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, type: "StakeTokens")
  end

  defdelegate from_account(stitch_plans, params), to: StitchPlan

  def to_validator(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:to_validator, :address], value: address]]

    stitch_plan ++ stitch_plans
  end

  defdelegate amount(stitch_plans, params), to: StitchPlan

  def token_identifier(stitch_plans, params) do
    StitchPlan.token_identifier(stitch_plans, params, [:amount])
  end
end
