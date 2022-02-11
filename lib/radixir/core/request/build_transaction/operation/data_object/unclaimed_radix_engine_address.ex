defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.UnclaimedRadixEngineAddress do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "UnclaimedRadixEngineAddress"], [:data, :data_object])
  end
end
