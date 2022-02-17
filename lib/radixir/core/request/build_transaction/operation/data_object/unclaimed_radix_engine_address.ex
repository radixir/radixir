defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.UnclaimedRadixEngineAddress do
  @moduledoc """
  Methods to create each map in `UnclaimedRadixEngineAddress` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `UnclaimedRadixEngineAddress` map. Value is set to `UnclaimedRadixEngineAddress`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "UnclaimedRadixEngineAddress"], [:data, :data_object])
  end
end
