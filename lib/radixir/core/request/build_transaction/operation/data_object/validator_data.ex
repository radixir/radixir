defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.ValidatorData do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "ValidatorData"], [:data, :data_object])
  end

  def owner(stitch_plans, params) do
    StitchPlan.owner(stitch_plans, params, [:data, :data_object])
  end

  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:data, :data_object, :owner])
  end

  def registered(stitch_plans, params) do
    StitchPlan.registered(stitch_plans, params, [:data, :data_object])
  end

  def fee(stitch_plans, params) do
    StitchPlan.fee(stitch_plans, params, [:data, :data_object])
  end
end
