defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.PreparedValidatorOwner do
  @moduledoc """
  Methods to create each map in `PreparedValidatorOwner` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `PreparedValidatorOwner` map. Value is set to `PreparedValidatorOwner`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "PreparedValidatorOwner"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `owner` map in `PreparedValidatorOwner` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Owner address.
  """
  @spec owner(stitch_plans, params) :: stitch_plans
  def owner(stitch_plans, params) do
    StitchPlan.owner(stitch_plans, params, [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `sub_entity` map in `PreparedValidatorOwner` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Sub Entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
  """
  @spec sub_entity(stitch_plans, params) :: stitch_plans
  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:data, :data_object, :owner])
  end

  @doc """
  Generates stitch plan for `epoch` map in `PreparedValidatorOwner` map.

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
