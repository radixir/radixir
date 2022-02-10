defmodule Radixir.Core.Operation.DataObject.ValidatorMetadata do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "ValidatorMetadata"], [:data, :data_object])
  end

  def name(stitch_plans, params) do
    schema = [
      name: [
        type: :integer,
        required: true
      ]
    ]

    name =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:name)

    stitch_plan = [[keys: [:data, :data_object, :name], value: name]]

    stitch_plan ++ stitch_plans
  end

  def url(stitch_plans, params) do
    RequestPiece.url(stitch_plans, params, [:data, :data_object])
  end
end
