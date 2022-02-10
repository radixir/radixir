defmodule Radixir.Core.Operation.DataObject.ValidatorBFTdata do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "ValidatorBFTdata"], [:data, :data_object])
  end

  def proposals_completed(stitch_plans, params) do
    schema = [
      proposals_completed: [
        type: :integer,
        required: true
      ]
    ]

    proposals_completed =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:proposals_completed)

    stitch_plan = [
      [keys: [:data, :data_object, :proposals_completed], value: proposals_completed]
    ]

    stitch_plan ++ stitch_plans
  end

  def proposals_missed(stitch_plans, params) do
    schema = [
      proposals_missed: [
        type: :integer,
        required: true
      ]
    ]

    proposals_missed =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:proposals_missed)

    stitch_plan = [[keys: [:data, :data_object, :proposals_missed], value: proposals_missed]]

    stitch_plan ++ stitch_plans
  end
end
