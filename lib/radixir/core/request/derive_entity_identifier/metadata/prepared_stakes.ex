defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.PreparedStakes do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "PreparedStakes"], [:metadata])
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
end
