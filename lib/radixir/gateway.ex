defmodule Radixir.Gateway do
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
