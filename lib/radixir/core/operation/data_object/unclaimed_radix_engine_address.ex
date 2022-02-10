defmodule Radixir.Core.Operation.DataObject.UnclaimedRadixEngineAddress do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "UnclaimedRadixEngineAddress"], [:data, :data_object])
  end
end
