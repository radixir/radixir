defmodule Radixir.Common do
  def network_identifier(stitch_plans, params) do
    schema = [
      network: [
        type: :string,
        required: true
      ]
    ]

    network =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:network)

    stitch_plan = [[keys: [:network_identifier, :network], value: network]]

    stitch_plan ++ stitch_plans
  end

  def transaction_identifier(stitch_plans, params) do
    schema = [
      hash: [
        type: :string,
        required: true
      ]
    ]

    hash =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:hash)

    stitch_plan = [[keys: [:transaction_identifier, :hash], value: hash]]

    stitch_plan ++ stitch_plans
  end

  def unsigned_transaction(stitch_plans, params) do
    schema = [
      unsigned_transaction: [
        type: :string,
        required: true
      ]
    ]

    unsigned_transaction =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:unsigned_transaction)

    stitch_plan = [[keys: [:unsigned_transaction], value: unsigned_transaction]]

    stitch_plan ++ stitch_plans
  end

  def signed_transaction(stitch_plans, params) do
    schema = [
      signed_transaction: [
        type: :string,
        required: true
      ]
    ]

    signed_transaction =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:signed_transaction)

    stitch_plan = [[keys: [:signed_transaction], value: signed_transaction]]

    stitch_plan ++ stitch_plans
  end

  def message(stitch_plans, params) do
    schema = [
      message: [
        type: :string,
        required: true
      ]
    ]

    message =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:message)

    stitch_plan = [[keys: [:message], value: message]]

    stitch_plan ++ stitch_plans
  end

  def limit(stitch_plans, params) do
    schema = [
      limit: [
        type: :integer,
        required: true
      ]
    ]

    limit =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:limit)

    stitch_plan = [[keys: [:limit], value: limit]]

    stitch_plan ++ stitch_plans
  end

  def public_key(stitch_plans, params) do
    schema = [
      hex: [
        type: :string,
        required: true
      ]
    ]

    hex =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:hex)

    stitch_plan = [[keys: [:public_key, :hex], value: hex]]

    stitch_plan ++ stitch_plans
  end

  def signature(stitch_plans, params) do
    schema = [
      bytes: [
        type: :string,
        required: true
      ],
      hex: [
        type: :string,
        required: true
      ]
    ]

    results = NimbleOptions.validate!(params, schema)

    bytes = [keys: [:signature, :bytes], value: Keyword.get(results, :bytes)]
    hex = [keys: [:signature, :public_key, :hex], value: Keyword.get(results, :hex)]

    stitch_plan = [bytes, hex]

    stitch_plan ++ stitch_plans
  end
end
