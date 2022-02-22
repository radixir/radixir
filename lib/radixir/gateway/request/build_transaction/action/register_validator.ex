defmodule Radixir.Gateway.Request.BuildTransaction.Action.RegisterValidator do
  @moduledoc """
  Methods to create each map in `RegisterValidator` action.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `RegisterValidator` action. Value is set to `RegisterValidator`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, type: "RegisterValidator")
  end

  @doc """
  Generates stitch plan for `validator_identifier` map in `RegisterValidator` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec validator(stitch_plans, params) :: stitch_plans
  def validator(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:validator, :address], value: address]]

    stitch_plan ++ stitch_plans
  end
end
