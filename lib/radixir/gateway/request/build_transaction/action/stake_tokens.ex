defmodule Radixir.Gateway.Request.BuildTransaction.Action.StakeTokens do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `StakeTokens` action.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `StakeTokens` action. Value is set to `StakeTokens`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, type: "StakeTokens")
  end

  @doc """
  Generates stitch plan for `from_account` map in `StakeTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec from_account(stitch_plans, params) :: stitch_plans
  defdelegate from_account(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `to_validator` map in `StakeTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec to_validator(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `amount` map in `StakeTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `amount` (required, string): Amount value.
  """
  @spec amount(stitch_plans, params) :: stitch_plans
  defdelegate amount(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `token_identifier` map in `StakeTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `rri` (required, string): Radix Resource Identifier.
  """
  @spec token_identifier(stitch_plans, params) :: stitch_plans
  def token_identifier(stitch_plans, params) do
    StitchPlan.token_identifier(stitch_plans, params, [:amount])
  end
end
