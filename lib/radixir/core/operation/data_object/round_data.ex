defmodule Radixir.Core.Operation.DataObject.RoundData do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "RoundData"], [:data, :data_object])
  end

  def round(stitch_plans, params) do
    schema = [
      round: [
        type: :integer,
        required: true
      ]
    ]

    round =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:round)

    stitch_plan = [[keys: [:data, :data_object, :round], value: round]]

    stitch_plan ++ stitch_plans
  end

  def timestamp(stitch_plans, params) do
    schema = [
      timestamp: [
        type: :integer,
        required: true
      ]
    ]

    timestamp =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:timestamp)

    stitch_plan = [[keys: [:data, :data_object, :timestamp], value: timestamp]]

    stitch_plan ++ stitch_plans
  end
end
