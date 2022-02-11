defmodule Radixir.StitchPlan do
  alias Radixir.Config
  alias Radixir.Util

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

  def token_identifier(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      rri: [
        type: :string,
        required: true
      ]
    ]

    rri =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:rri)

    stitch_plan = [[keys: prefix_keys ++ [:token_identifier, :rri], value: rri]]

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

  def symbol(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      symbol: [
        type: :string,
        required: true
      ]
    ]

    symbol =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:symbol)

    stitch_plan = [[keys: prefix_keys ++ [:symbol], value: symbol]]

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

  def amount(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      value: [
        type: :string,
        required: true
      ]
    ]

    value =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:value)

    stitch_plan = [[keys: prefix_keys ++ [:amount, :value], value: value]]

    stitch_plan ++ stitch_plans
  end

  def to_account(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:to_account, :address], value: address]]

    stitch_plan ++ stitch_plans
  end

  def from_account(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:from_account, :address], value: address]]

    stitch_plan ++ stitch_plans
  end

  def to(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      to: [
        type: :string,
        required: true
      ]
    ]

    to =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:to)

    stitch_plan = [[keys: prefix_keys ++ [:to], value: to]]

    stitch_plan ++ stitch_plans
  end

  def from(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      from: [
        type: :string,
        required: true
      ]
    ]

    from =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:from)

    stitch_plan = [[keys: prefix_keys ++ [:from], value: from]]

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

  def state_identifier(stitch_plans, params) do
    schema = [
      state_version: [
        type: :integer,
        required: true
      ],
      transaction_accumulator: [
        type: :string
      ]
    ]

    results = NimbleOptions.validate!(params, schema)

    state_version = [
      keys: [:state_identifier, :state_version],
      value: Keyword.get(results, :state_version)
    ]

    transaction_accumulator =
      Keyword.get(results, :transaction_accumulator)
      |> Util.optional_params([:state_identifier, :transaction_accumulator])

    stitch_plan = [state_version, transaction_accumulator] |> Enum.filter(fn x -> x != [] end)

    stitch_plan ++ stitch_plans
  end

  def network_identifier(stitch_plans, params \\ []) do
    schema = [
      network: [
        type: :string,
        default: Config.network()
      ]
    ]

    network =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:network)

    stitch_plan = [[keys: [:network_identifier, :network], value: network]]

    stitch_plan ++ stitch_plans
  end

  def entity_identifier(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:entity_identifier, :address], value: address]]

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

  def type(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      type: [
        type: :string,
        required: true
      ]
    ]

    type =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:type)

    stitch_plan = [[keys: prefix_keys ++ [:type], value: type]]

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

  def owner(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: prefix_keys ++ [:owner, :address], value: address]]

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

  def signed(stitch_plans, params) do
    schema = [
      signed: [
        type: :boolean,
        required: true
      ]
    ]

    signed =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:signed)

    stitch_plan = [[keys: [:signed], value: signed]]

    stitch_plan ++ stitch_plans
  end

  def transaction(stitch_plans, params) do
    schema = [
      transaction: [
        type: :string,
        required: true
      ]
    ]

    transaction =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:transaction)

    stitch_plan = [[keys: [:transaction], value: transaction]]

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

  def name(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      name: [
        type: :integer,
        required: true
      ]
    ]

    name =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:name)

    stitch_plan = [[keys: prefix_keys ++ [:name], value: name]]

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

  def url(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      url: [
        type: :string,
        required: true
      ]
    ]

    url =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:url)

    stitch_plan = [[keys: prefix_keys ++ [:url], value: url]]

    stitch_plan ++ stitch_plans
  end

  def fee(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      fee: [
        type: :integer,
        required: true
      ]
    ]

    fee =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:fee)

    stitch_plan = [[keys: prefix_keys ++ [:fee], value: fee]]

    stitch_plan ++ stitch_plans
  end

  def registered(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      registered: [
        type: :boolean,
        required: true
      ]
    ]

    registered =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:registered)

    stitch_plan = [[keys: prefix_keys ++ [:registered], value: registered]]

    stitch_plan ++ stitch_plans
  end

  def epoch(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      epoch: [
        type: :integer,
        required: true
      ]
    ]

    epoch =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:epoch)

    stitch_plan = [[keys: prefix_keys ++ [:epoch], value: epoch]]

    stitch_plan ++ stitch_plans
  end

  def validator(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: prefix_keys ++ [:validator, :address], value: address]]

    stitch_plan ++ stitch_plans
  end

  def sub_entity(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      address: [
        type: :string,
        required: true
      ],
      validator_address: [
        type: :string
      ],
      epoch_unlock: [
        type: :integer
      ]
    ]

    results = NimbleOptions.validate!(params, schema)

    address = [
      keys: prefix_keys ++ [:sub_entity, :address],
      value: Keyword.get(results, :address)
    ]

    validator_address =
      Keyword.get(results, :validator_address)
      |> Util.optional_params(prefix_keys ++ [:sub_entity, :metadata, :validator_address])

    epoch_unlock =
      Keyword.get(results, :epoch_unlock)
      |> Util.optional_params(prefix_keys ++ [:sub_entity, :metadata, :epoch_unlock])

    stitch_plan = [address, validator_address, epoch_unlock] |> Enum.filter(fn x -> x != [] end)

    stitch_plan ++ stitch_plans
  end
end
