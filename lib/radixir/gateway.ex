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

  def disable_token_mint_and_burn(stitch_plans, params) do
    schema = [
      disable_token_mint_and_burn: [
        type: :string,
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
