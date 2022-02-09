defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.ExitingUnstakes do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "ExitingUnstakes"], [:metadata])
  end

  def validator(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:metadata, :validator, :address], value: address]]

    stitch_plan ++ stitch_plans
  end

  def sub_entity(stitch_plans, params) do
    RequestPiece.sub_entity(stitch_plans, params, [:metadata, :validator])
  end

  def epoch_unlock(stitch_plans, params) do
    schema = [
      epoch_unlock: [
        type: :integer,
        required: true
      ]
    ]

    epoch_unlock =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:epoch_unlock)

    stitch_plan = [[keys: [:epoch_unlock], value: epoch_unlock]]

    stitch_plan ++ stitch_plans
  end
end
