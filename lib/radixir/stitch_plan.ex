defmodule Radixir.StitchPlan do
  @moduledoc false
  # @moduledoc """
  # Generates stitch plans for maps that are used in requests.
  # """
  alias Radixir.Config
  alias Radixir.Util

  @type stitch_plans :: list(keyword)
  @type params :: keyword
  @type prefix_keys :: list(atom())

  @doc """
  Generates stitch plan for `account_identifier` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.

  ## Examples
      iex> Radixir.StitchPlan.account_identifier([], [address: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"])
      [
        [
          keys: [:account_identifier, :address],
          value: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"
        ]
      ]
  """
  @spec account_identifier(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `validator_identifier` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.

  ## Examples
      iex> Radixir.StitchPlan.validator_identifier([], [address: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"])
      [
        [
          keys: [:validator_identifier, :address],
          value: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"
        ]
      ]
  """
  @spec validator_identifier(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `token_identifier` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `rri` (required, string): Radix Resource Identifier.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.token_identifier([], [rri: "xrd_tr1qyf0x76s"], [:hello, :there])
      [
        [
          keys: [:hello, :there, :token_identifier, :rri],
          value: "xrd_tr1qyf0x76s"
        ]
      ]
  """
  @spec token_identifier(stitch_plans, params, prefix_keys) :: stitch_plans
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

  @doc """
  Generates stitch plan for `at_state_identifier` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `version` (optional, integer): Version.
      - `timestamp` (optional, string): Timestamp.
      - `epoch` (optional, integer): Epoch.
      - `round` (optional, integer): Round.

  ## Examples
      iex> Radixir.StitchPlan.at_state_identifier([], [version: 9000, round: 90])
      [
        [keys: [:at_state_identifier, :version], value: 9000],
        [keys: [:at_state_identifier, :round], value: 90]
      ]
  """
  @spec at_state_identifier(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `symbol` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `symbol` (required, string): Symbol.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.symbol([], [symbol: "veg"])
      [
        [
          keys: [:symbol],
          value: "veg"
        ]
      ]
  """
  @spec symbol(stitch_plans, params, prefix_keys) :: stitch_plans
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

  @doc """
  Generates stitch plan for `cursor` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `cursor` (required, string): Cursor.

  ## Examples
      iex> Radixir.StitchPlan.cursor([], [cursor: "asdfasdf"])
      [
        [
          keys: [:cursor],
          value: "asdfasdf"
        ]
      ]
  """
  @spec cursor(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `fee_payer` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.

  ## Examples
      iex> Radixir.StitchPlan.fee_payer([], [address: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"])
      [
        [
          keys: [:fee_payer, :address],
          value: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"
        ]
      ]
  """
  @spec fee_payer(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `submit` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `submit` (required, boolean): Submit.

  ## Examples
      iex> Radixir.StitchPlan.submit([], [submit: false])
      [
        [
          keys: [:submit],
          value: false
        ]
      ]
  """
  @spec submit(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `amount` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `amount` (required, string): Amount value.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.amount([], [amount: "10"])
      [
        [
          keys: [:amount, :value],
          value: "10"
        ]
      ]
  """
  @spec amount(stitch_plans, params, prefix_keys) :: stitch_plans
  def amount(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      amount: [
        type: :string,
        required: true
      ]
    ]

    amount =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:amount)

    stitch_plan = [[keys: prefix_keys ++ [:amount, :value], value: amount]]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `to_account` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.

  ## Examples
      iex> Radixir.StitchPlan.to_account([], [address: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"])
      [
        [
          keys: [:to_account, :address],
          value: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"
        ]
      ]
  """
  @spec to_account(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `from_account` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.

  ## Examples
      iex> Radixir.StitchPlan.from_account([], [address: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"])
      [
        [
          keys: [:from_account, :address],
          value: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"
        ]
      ]
  """
  @spec from_account(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `to` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `to` (required, string): Radix address.

  ## Examples
      iex> Radixir.StitchPlan.to([], [to: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"])
      [
        [
          keys: [:to],
          value: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"
        ]
      ]
  """
  @spec to(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `from` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `from` (required, string): Radix address.

  ## Examples
      iex> Radixir.StitchPlan.from([], [from: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"])
      [
        [
          keys: [:from],
          value: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"
        ]
      ]
  """
  @spec from(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `disable_token_mint_and_burn` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `disable_token_mint_and_burn` (required, boolean): Disable Token Mint and Burn.

  ## Examples
      iex> Radixir.StitchPlan.disable_token_mint_and_burn([], [disable_token_mint_and_burn: true])
      [
        [
          keys: [:disable_token_mint_and_burn],
          value: true
        ]
      ]
  """
  @spec disable_token_mint_and_burn(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `state_identifier` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `state_version` (required, integer): State Version.
      - `transaction_accumulator` (optional, string): Transaction Accumulator.

  ## Examples
      iex> Radixir.StitchPlan.state_identifier([], [state_version: 9000])
      [
        [
          keys: [:state_identifier, :state_version],
          value: 9000
        ]
      ]
  """
  @spec state_identifier(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `network_identifier` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `network` (optional, string): If `network` is not in `params` then it will default to what is returned from `Radixir.Config.network()`.

  ## Examples
      iex> Radixir.StitchPlan.network_identifier([], [network: "mainnet"])
      [
        [
          keys: [:network_identifier, :network],
          value: "mainnet"
        ]
      ]
  """
  @spec network_identifier(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `entity_identifier` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.

  ## Examples
      iex> Radixir.StitchPlan.entity_identifier([], [address: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"])
      [
        [
          keys: [:entity_identifier, :address],
          value: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"
        ]
      ]
  """
  @spec entity_identifier(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `transaction_identifier` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `hash` (required, string): Transaction Identifer hash.

  ## Examples
      iex> Radixir.StitchPlan.transaction_identifier([], [hash: "ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e578f60d99337193811842"])
      [
        [
          keys: [:transaction_identifier, :hash],
          value: "ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e578f60d99337193811842"
        ]
      ]
  """
  @spec transaction_identifier(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `type` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `type` (required, string): Type.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.type([], [type: "TokenTransfer"])
      [
        [
          keys: [:type],
          value: "TokenTransfer"
        ]
      ]
  """
  @spec type(stitch_plans, params, prefix_keys) :: stitch_plans
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

  @doc """
  Generates stitch plan for `unsigned_transaction` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `unsigned_transaction` (required, string): Unsigned Transaction.

  ## Examples
      iex> Radixir.StitchPlan.unsigned_transaction([], [unsigned_transaction: "ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e578f60d99337193811842ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e578f60d99337193811842"])
      [
        [
          keys: [:unsigned_transaction],
          value: "ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e578f60d99337193811842ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e578f60d99337193811842"
        ]
      ]
  """
  @spec unsigned_transaction(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `signed_transaction` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `signed_transaction` (required, string): Signed Transaction.

  ## Examples
      iex> Radixir.StitchPlan.signed_transaction([], [signed_transaction: "ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e578f60d99337193811842ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e578f60d99337193811842"])
      [
        [
          keys: [:signed_transaction],
          value: "ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e578f60d99337193811842ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e578f60d99337193811842"
        ]
      ]
  """
  @spec signed_transaction(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `owner` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Owner address.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.owner([], [address: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"])
      [
        [
          keys: [:owner, :address],
          value: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"
        ]
      ]
  """
  @spec owner(stitch_plans, params, prefix_keys) :: stitch_plans
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

  @doc """
  Generates stitch plan for `message` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `message` (required, string): Message.

  ## Examples
      iex> Radixir.StitchPlan.message([], [message: "hello"])
      [
        [
          keys: [:message],
          value: "hello"
        ]
      ]
  """
  @spec message(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `signed` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `signed` (required, boolean): Signed.

  ## Examples
      iex> Radixir.StitchPlan.signed([], [signed: true])
      [
        [
          keys: [:signed],
          value: true
        ]
      ]
  """
  @spec signed(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `transaction` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `transaction` (required, string): Transaction.

  ## Examples
      iex> Radixir.StitchPlan.transaction([], [transaction: "ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e57fce6abd2df8fab2755cfb51f6794e578f60d99337193811842"])
      [
        [
          keys: [:transaction],
          value: "ef71a9d6c63444fce6abd2df8fab2755cfb51f6794e57fce6abd2df8fab2755cfb51f6794e578f60d99337193811842"
        ]
      ]
  """
  @spec transaction(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `limit` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `limit` (required, integer): Limit.

  ## Examples
      iex> Radixir.StitchPlan.limit([], [limit: 3])
      [
        [
          keys: [:limit],
          value: 3
        ]
      ]
  """
  @spec limit(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `public_key` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `hex` (required, integer): Public key hex.

  ## Examples
      iex> Radixir.StitchPlan.public_key([], [hex: "027fb52f10ba5bded8c0eecee189eaecb9592353bfe8380989e2223447cfd0f2f8"])
      [
        [
          keys: [:public_key, :hex],
          value: "027fb52f10ba5bded8c0eecee189eaecb9592353bfe8380989e2223447cfd0f2f8"
        ]
      ]
  """
  @spec public_key(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `name` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `name` (required, string): Name.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.name([], [name: "doug"])
      [
        [
          keys: [:name],
          value: "doug"
        ]
      ]
  """
  @spec name(stitch_plans, params, prefix_keys) :: stitch_plans
  def name(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      name: [
        type: :string,
        required: true
      ]
    ]

    name =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:name)

    stitch_plan = [[keys: prefix_keys ++ [:name], value: name]]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `signature` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `bytes` (required, string): Signature bytes.
      - `hex` (required, string): Signature public key hex.

  ## Examples
      iex> Radixir.StitchPlan.signature([], [hex: "027fb52f10ba5bded8c0eecee189eaecb9592353bfe8380989e2223447cfd0f2f8", bytes: "klsdjklsdljksdfdlskfj"])
      [
        [keys: [:signature, :bytes], value: "klsdjklsdljksdfdlskfj"],
        [
          keys: [:signature, :public_key, :hex],
          value: "027fb52f10ba5bded8c0eecee189eaecb9592353bfe8380989e2223447cfd0f2f8"
        ]
      ]
  """
  @spec signature(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `url` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `url` (required, string): Url.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.url([], [url: "https://google.com"])
      [
        [
          keys: [:url],
          value: "https://google.com"
        ]
      ]
  """
  @spec url(stitch_plans, params, prefix_keys) :: stitch_plans
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

  @doc """
  Generates stitch plan for `fee` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `fee` (required, integer): Fee.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.fee([], [fee: 2000000])
      [
        [
          keys: [:fee],
          value: 2000000
        ]
      ]
  """
  @spec fee(stitch_plans, params, prefix_keys) :: stitch_plans
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

  @doc """
  Generates stitch plan for `registered` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `registered` (required, boolean): Registered.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.registered([], [registered: true])
      [
        [
          keys: [:registered],
          value: true
        ]
      ]
  """
  @spec registered(stitch_plans, params, prefix_keys) :: stitch_plans
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

  @doc """
  Generates stitch plan for `epoch` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `epoch` (required, integer): Epoch.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.epoch([], [epoch: 8])
      [
        [
          keys: [:epoch],
          value: 8
        ]
      ]
  """
  @spec epoch(stitch_plans, params, prefix_keys) :: stitch_plans
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

  @doc """
  Generates stitch plan for `validator` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Validator address.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.validator([], [address: "rvx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"])
      [
        [
          keys: [:validator, :address],
          value: "rvx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"
        ]
      ]
  """
  @spec validator(stitch_plans, params, prefix_keys) :: stitch_plans
  def validator(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      validator_address: [
        type: :string,
        required: true
      ]
    ]

    validator_address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:validator_address)

    stitch_plan = [[keys: prefix_keys ++ [:validator, :address], value: validator_address]]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `sub_entity` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `sub_entity_address` (required, string): Sub Entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.

  ## Examples
      iex> Radixir.StitchPlan.sub_entity([], [address: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"])
      [
        [
          keys: [:sub_entity, :address],
          value: "rdx1qspxpjejcn3przwrf7lvaaftm84ufrmf9yccd6xxnaj96kwykr59hvgnv42z7"
        ]
      ]
  """
  @spec sub_entity(stitch_plans, params, prefix_keys) :: stitch_plans
  def sub_entity(stitch_plans, params, prefix_keys \\ []) do
    schema = [
      sub_entity_address: [
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

    sub_entity_address = [
      keys: prefix_keys ++ [:sub_entity, :address],
      value: Keyword.get(results, :sub_entity_address)
    ]

    validator_address =
      Keyword.get(results, :validator_address)
      |> Util.optional_params(prefix_keys ++ [:sub_entity, :metadata, :validator_address])

    epoch_unlock =
      Keyword.get(results, :epoch_unlock)
      |> Util.optional_params(prefix_keys ++ [:sub_entity, :metadata, :epoch_unlock])

    stitch_plan =
      [sub_entity_address, validator_address, epoch_unlock] |> Enum.filter(fn x -> x != [] end)

    stitch_plan ++ stitch_plans
  end
end
