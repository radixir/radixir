defmodule Radixir.Gateway do
  alias Radixir.Util

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

  def account_identifier(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:account_identifier, :address], value: address]]

    stitch_plan ++ stitch_plans
  end

  def validator_identifier(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:validator_identifier, :address], value: address]]

    stitch_plan ++ stitch_plans
  end

  def token_identifier(stitch_plans, params) do
    schema = [
      rri: [
        type: :string,
        required: true
      ]
    ]

    rri =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:rri)

    stitch_plan = [[keys: [:token_identifier, :rri], value: rri]]

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

  def at_state_identifier(stitch_plans, params) do
    schema = [
      version: [
        type: :integer
      ],
      timestamp: [
        type: :string
      ],
      epoch: [
        type: :integer
      ],
      round: [
        type: :integer
      ]
    ]

    results = NimbleOptions.validate!(params, schema)

    version =
      Keyword.get(results, :version)
      |> Util.optional_params([:at_state_identifier, :version])

    timestamp =
      Keyword.get(results, :timestamp)
      |> Util.optional_params([:at_state_identifier, :timestamp])

    epoch =
      Keyword.get(results, :epoch)
      |> Util.optional_params([:at_state_identifier, :epoch])

    round =
      Keyword.get(results, :round)
      |> Util.optional_params([:at_state_identifier, :round])

    stitch_plan = [version, timestamp, epoch, round] |> Enum.filter(fn x -> x != [] end)

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

  def symbol(stitch_plans, params) do
    schema = [
      symbol: [
        type: :string,
        required: true
      ]
    ]

    symbol =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:symbol)

    stitch_plan = [[keys: [:symbol], value: symbol]]

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

  def cursor(stitch_plans, params) do
    schema = [
      cursor: [
        type: :string,
        required: true
      ]
    ]

    cursor =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:cursor)

    stitch_plan = [[keys: [:cursor], value: cursor]]

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

  def fee_payer(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:fee_payer, :address], value: address]]

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

  def submit(stitch_plans, params) do
    schema = [
      submit: [
        type: :boolean,
        required: true
      ]
    ]

    submit =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:submit)

    stitch_plan = [[keys: [:submit], value: submit]]

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

  def disable_token_mint_and_burn(stitch_plans, params) do
    schema = [
      disable_token_mint_and_burn: [
        type: :boolean,
        required: true
      ]
    ]

    disable_token_mint_and_burn =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:disable_token_mint_and_burn)

    stitch_plan = [[keys: [:disable_token_mint_and_burn], value: disable_token_mint_and_burn]]

    stitch_plan ++ stitch_plans
  end
end
