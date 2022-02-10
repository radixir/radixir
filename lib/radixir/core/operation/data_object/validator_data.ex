defmodule Radixir.Core.Operation.DataObject.ValidatorData do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "ValidatorData"], [:data, :data_object])
  end

  def owner(stitch_plans, params) do
    RequestPiece.owner(stitch_plans, params, [:data, :data_object])
  end

  def sub_entity(stitch_plans, params) do
    RequestPiece.sub_entity(stitch_plans, params, [:data, :data_object, :owner])
  end

  def registered(stitch_plans, params) do
    RequestPiece.registered(stitch_plans, params, [:data, :data_object])
  end

  def fee(stitch_plans, params) do
    RequestPiece.fee(stitch_plans, params, [:data, :data_object])
  end
end
