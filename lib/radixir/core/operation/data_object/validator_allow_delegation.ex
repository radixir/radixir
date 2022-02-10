defmodule Radixir.Core.Operation.DataObject.ValidatorAllowDelegation do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "ValidatorAllowDelegation"], [:data, :data_object])
  end

  def allow_delegation(stitch_plans, params) do
    schema = [
      allow_delegation: [
        type: :boolean,
        required: true
      ]
    ]

    allow_delegation =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:allow_delegation)

    stitch_plan = [
      [keys: [:data, :data_object, :allow_delegation], value: allow_delegation]
    ]

    stitch_plan ++ stitch_plans
  end
end
