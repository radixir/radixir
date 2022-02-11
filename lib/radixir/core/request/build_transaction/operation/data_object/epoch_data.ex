defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.EpochData do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "EpochData"], [:data, :data_object])
  end

  def epoch(stitch_plans, params) do
    StitchPlan.epoch(stitch_plans, params, [:data, :data_object])
  end
end
