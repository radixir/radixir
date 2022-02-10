defmodule Radixir.Core.Operation.DataObject.TokenData do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "TokenData"], [:data, :data_object])
  end

  def granularity(stitch_plans, params) do
    schema = [
      granularity: [
        type: :string,
        required: true
      ]
    ]

    granularity =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:granularity)

    stitch_plan = [[keys: [:data, :data_object, :granularity], value: granularity]]

    stitch_plan ++ stitch_plans
  end

  def is_mutable(stitch_plans, params) do
    schema = [
      is_mutable: [
        type: :string,
        required: true
      ]
    ]

    is_mutable =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:is_mutable)

    stitch_plan = [[keys: [:data, :data_object, :is_mutable], value: is_mutable]]

    stitch_plan ++ stitch_plans
  end

  def owner(stitch_plans, params) do
    RequestPiece.owner(stitch_plans, params, [:data, :data_object])
  end

  def sub_entity(stitch_plans, params) do
    RequestPiece.sub_entity(stitch_plans, params, [:data, :data_object, :owner])
  end
end
