defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.PreparedValidatorRegistered do
  @moduledoc """
  Methods to create each map in `PreparedValidatorRegistered` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `PreparedValidatorRegistered` map. Value is set to `PreparedValidatorRegistered`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "PreparedValidatorRegistered"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `registered` map in `PreparedValidatorRegistered` map.

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
  Generates stitch plan for `epoch` map in `PreparedValidatorRegistered` map.

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
