defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.EpochData do
  @moduledoc """
  Methods to create each map in `EpochData` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `EpochData` map. Value is set to `EpochData`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "EpochData"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `epoch` map in `EpochData` map.

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
