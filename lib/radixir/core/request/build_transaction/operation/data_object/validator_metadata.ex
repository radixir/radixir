defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.ValidatorMetadata do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "ValidatorMetadata"], [:data, :data_object])
  end

  def name(stitch_plans, params) do
    StitchPlan.name(stitch_plans, params, [:data, :data_object])
  end

  def url(stitch_plans, params) do
    StitchPlan.url(stitch_plans, params, [:data, :data_object])
  end
end
