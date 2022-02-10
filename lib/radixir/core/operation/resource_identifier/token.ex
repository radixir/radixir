defmodule Radixir.Core.Operation.ResourceIdentifier.Token do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "Token"], [:amount, :resource_identifier])
  end

  def rri(stitch_plans, params) do
    schema = [
      rri: [
        type: :string,
        required: true
      ]
    ]

    rri =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:rri)

    stitch_plan = [[keys: [:amount, :resource_identifier, :rri], value: rri]]

    stitch_plan ++ stitch_plans
  end
end
