defmodule Radixir.Core do
  def state_identifier(stitch_plans, params) do
    schema = [
      state_version: [
        type: :integer,
        required: true
      ],
      transaction_accumulator: [
        type: :string,
        required: true
      ]
    ]

    results = NimbleOptions.validate!(params, schema)

    state_version = [
      keys: [:state_identifier, :state_version],
      value: Keyword.get(results, :state_version)
    ]

    transaction_accumulator = [
      keys: [:state_identifier, :transaction_accumulator],
      value: Keyword.get(results, :transaction_accumulator)
    ]

    stitch_plan = [state_version, transaction_accumulator]

    stitch_plan ++ stitch_plans
  end
end
