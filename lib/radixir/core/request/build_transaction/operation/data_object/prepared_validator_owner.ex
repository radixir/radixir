defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.PreparedValidatorOwner do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "PreparedValidatorOwner"], [:data, :data_object])
  end

  def owner(stitch_plans, params) do
    StitchPlan.owner(stitch_plans, params, [:data, :data_object])
  end

  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:data, :data_object, :owner])
  end

  def epoch(stitch_plans, params) do
    StitchPlan.epoch(stitch_plans, params, [:data, :data_object])
  end
end
