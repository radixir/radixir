defmodule Radixir.RequestPiece.ResourceIdentifier.Token do
  def resource_identifier(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      rri: [
        type: :string,
        required: true
      ]
    ]

    rri_value =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:rri)

    rri = [keys: prefix_keys ++ [:resource_identifier, :rri], value: rri_value]
    type = [keys: prefix_keys ++ [:resource_identifier, :type], value: "Token"]

    stitch_plan = [rri, type]

    stitch_plan ++ stitch_plans
  end
end
