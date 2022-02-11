defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.PreparedValidatorFee do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "PreparedValidatorFee"], [:data, :data_object])
  end

  def fee(stitch_plans, params) do
    StitchPlan.fee(stitch_plans, params, [:data, :data_object])
  end

  def epoch(stitch_plans, params) do
    StitchPlan.epoch(stitch_plans, params, [:data, :data_object])
  end
end
