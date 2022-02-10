defmodule Radixir.Core.Operation.DataObject.ValidatorSystemMetadata do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "ValidatorSystemMetadata"], [:data, :data_object])
  end

  def date(stitch_plans, params) do
    schema = [
      date: [
        type: :string,
        required: true
      ]
    ]

    date =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:date)

    stitch_plan = [[keys: [:data, :data_object, :date], value: date]]

    stitch_plan ++ stitch_plans
  end
end
