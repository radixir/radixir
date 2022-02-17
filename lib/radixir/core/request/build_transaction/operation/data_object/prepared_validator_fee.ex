defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.PreparedValidatorFee do
  @moduledoc """
  Methods to create each map in `PreparedValidatorFee` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `PreparedValidatorFee` map. Value is set to `PreparedValidatorFee`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "PreparedValidatorFee"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `fee` map in `PreparedValidatorFee` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `fee` (required, integer): Fee.
  """
  @spec fee(stitch_plans, params) :: stitch_plans
  def fee(stitch_plans, params) do
    StitchPlan.fee(stitch_plans, params, [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `epoch` map in `PreparedValidatorFee` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `epoch` (required, integer): Epoch.
  """
  @spec epoch(stitch_plans, params) :: stitch_plans
  def epoch(stitch_plans, params) do
    StitchPlan.epoch(stitch_plans, params, [:data, :data_object])
  end
end
