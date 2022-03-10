defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.ValidatorData do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `ValidatorData` map.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `ValidatorData` map. Value is set to `ValidatorData`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "ValidatorData"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `owner` map in `ValidatorData` map.

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
  Generates stitch plan for `sub_entity` map in `ValidatorData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `sub_entity_address` (required, string): Sub Entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
  """
  @spec sub_entity(stitch_plans, params) :: stitch_plans
  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:data, :data_object, :owner])
  end

  @doc """
  Generates stitch plan for `registered` map in `ValidatorData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `registered` (required, boolean): Registered.
  """
  @spec registered(stitch_plans, params) :: stitch_plans
  def registered(stitch_plans, params) do
    StitchPlan.registered(stitch_plans, params, [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `fee` map in `ValidatorData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `fee` (required, integer): Fee.
  """
  @spec fee(stitch_plans, params) :: stitch_plans
  def fee(stitch_plans, params) do
    StitchPlan.fee(stitch_plans, params, [:data, :data_object])
  end
end
