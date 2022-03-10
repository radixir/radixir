defmodule Radixir.Gateway.Request.BuildTransaction.Action.MintTokens do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `MintTokens` action.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `MintTokens` action. Value is set to `MintTokens`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, type: "MintTokens")
  end

  @doc """
  Generates stitch plan for `to_account` map in `MintTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec to_account(stitch_plans, params) :: stitch_plans
  defdelegate to_account(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `amount` map in `MintTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `amount` (required, string): Amount value.
  """
  @spec amount(stitch_plans, params) :: stitch_plans
  defdelegate amount(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `token_identifier` map in `MintTokens` action.

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
