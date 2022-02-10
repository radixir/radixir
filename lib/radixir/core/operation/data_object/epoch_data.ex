defmodule Radixir.Core.Operation.DataObject.EpochData do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "EpochData"], [:data, :data_object])
  end

  def epoch(stitch_plans, params) do
    RequestPiece.epoch(stitch_plans, params, [:data, :data_object])
  end
end
