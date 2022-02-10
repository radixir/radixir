defmodule Radixir.Gateway.Action.CreateToken do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, type: "CreateTokenDefinition")
  end

  def token_properties(stitch_plans, params) do
    schema = [
      name: [
        type: :string,
        required: true
      ],
      description: [
        type: :string,
        required: true
      ],
      icon_url: [
        type: :string,
        required: true
      ],
      url: [
        type: :string,
        required: true
      ],
      symbol: [
        type: :string,
        required: true
      ],
      is_supply_mutable: [
        type: :boolean,
        required: true
      ],
      granularity: [
        type: :string,
        required: true
      ]
    ]

    results = NimbleOptions.validate!(params, schema)

    name = [keys: [:token_properties, :name], value: Keyword.get(results, :name)]

    description = [
      keys: [:token_properties, :description],
      value: Keyword.get(results, :description)
    ]

    icon_url = [keys: [:token_properties, :icon_url], value: Keyword.get(results, :icon_url)]
    url = [keys: [:token_properties, :url], value: Keyword.get(results, :url)]
    symbol = [keys: [:token_properties, :symbol], value: Keyword.get(results, :symbol)]

    is_supply_mutable = [
      keys: [:token_properties, :is_supply_mutable],
      value: Keyword.get(results, :is_supply_mutable)
    ]

    granularity = [
      keys: [:token_properties, :granularity],
      value: Keyword.get(results, :granularity)
    ]

    stitch_plan = [name, description, icon_url, url, symbol, is_supply_mutable, granularity]

    stitch_plan ++ stitch_plans
  end

  def owner(stitch_plans, params) do
    RequestPiece.owner(stitch_plans, params, [:token_properties])
  end

  def token_supply(stitch_plans, params) do
    schema = [
      value: [
        type: :string,
        required: true
      ]
    ]

    value =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:value)

    stitch_plan = [[keys: [:token_supply, :value], value: value]]

    stitch_plan ++ stitch_plans
  end

  def token_identifier(stitch_plans, params) do
    RequestPiece.token_identifier(stitch_plans, params, [:token_supply])
  end

  defdelegate to_account(stitch_plans, params), to: RequestPiece
end
