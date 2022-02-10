defmodule Radixir.Core.Operation.DataObject.PreparedValidatorOwner do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "PreparedValidatorOwner"], [:data, :data_object])
  end

  def owner(stitch_plans, params) do
    RequestPiece.owner(stitch_plans, params, [:data, :data_object])
  end

  def sub_entity(stitch_plans, params) do
    RequestPiece.sub_entity(stitch_plans, params, [:data, :data_object, :owner])
  end

  def epoch(stitch_plans, params) do
    RequestPiece.epoch(stitch_plans, params, [:data, :data_object])
  end
end
