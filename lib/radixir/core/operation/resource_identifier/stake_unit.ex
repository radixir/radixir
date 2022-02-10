defmodule Radixir.Core.Operation.ResourceIdentifier.StakeUnit do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "StakeUnit"], [:amount, :resource_identifier])
  end

  def validator_address(stitch_plans, params) do
    schema = [
      validator_address: [
        type: :string,
        required: true
      ]
    ]

    validator_address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:validator_address)

    stitch_plan = [
      [keys: [:amount, :resource_identifier, :validator_address], value: validator_address]
    ]

    stitch_plan ++ stitch_plans
  end
end
