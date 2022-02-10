defmodule Radixir.Core.Operation.DataObject.PreparedValidatorRegistered do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "PreparedValidatorRegistered"], [:data, :data_object])
  end

  def registered(stitch_plans, params) do
    RequestPiece.registered(stitch_plans, params, [:data, :data_object])
  end

  def epoch(stitch_plans, params) do
    RequestPiece.epoch(stitch_plans, params, [:data, :data_object])
  end
end
