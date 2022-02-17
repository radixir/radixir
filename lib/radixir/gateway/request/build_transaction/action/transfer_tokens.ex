defmodule Radixir.Gateway.Request.BuildTransaction.Action.TransferTokens do
  @moduledoc """
  Methods to create each map in `TransferTokens` action.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `TransferTokens` action. Value is set to `TransferTokens`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, type: "TransferTokens")
  end

  @doc """
  Generates stitch plan for `from_account` map in `TransferTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec from_account(stitch_plans, params) :: stitch_plans
  defdelegate from_account(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `to_account` map in `TransferTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec to_account(stitch_plans, params) :: stitch_plans
  defdelegate to_account(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `amount` map in `TransferTokens` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `value` (required, string): Amount value.
  """
  @spec amount(stitch_plans, params) :: stitch_plans
  defdelegate amount(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `token_identifier` map in `TransferTokens` action.

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
