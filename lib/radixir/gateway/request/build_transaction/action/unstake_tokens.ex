defmodule Radixir.Gateway.Request.BuildTransaction.Action.UnstakeTokens do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `UnstakeTokens` action.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword)
  @type params :: keyword

  @doc """
  Generates stitch plan for `type` map in `UntakeTokens` action. Value is set to `UntakeTokens`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, type: "UnstakeTokens")
  end

  @doc """
  Generates stitch plan for `from_validator` map in `UnstakeTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec from_validator(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `to_account` map in `UnstakeTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec to_account(stitch_plans, params) :: stitch_plans
  defdelegate to_account(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `amount` map in `UnstakeTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `amount` (required, string): Amount value.
  """
  @spec amount(stitch_plans, params) :: stitch_plans
  defdelegate amount(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `token_identifier` map in `UnstakeTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `rri` (required, string): Radix Resource Identifier.
  """
  @spec token_identifier(stitch_plans, params) :: stitch_plans
  def token_identifier(stitch_plans, params) do
    StitchPlan.token_identifier(stitch_plans, params, [:amount])
  end

  @doc """
  Generates stitch plan for `unstake_percentage` map in `UnstakeTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `unstake_percentage` (required, non_neg_integer): Radix Resource Identifier.
  """
  @spec unstake_percentage(stitch_plans, params) :: stitch_plans
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
