defmodule Radixir.Gateway.Actions.CreateToken do
  alias Radixir.Util

  @agent :create_token

  def type(stitch_plans) do
    keys_values = [[keys: [:type], value: "CreateTokenDefinition"]]
    put(keys_values)
    stitch_plans
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

    keys_values = [name, description, icon_url, url, symbol, is_supply_mutable, granularity]

    put(keys_values)
    stitch_plans
  end

  def owner(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    keys_values = [[keys: [:token_properties, :owner, :address], value: address]]

    put(keys_values)
    stitch_plans
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

    keys_values = [[keys: [:token_supply, :value], value: value]]

    put(keys_values)
    stitch_plans
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

    keys_values = [[keys: [:token_supply, :token_identifier, :rri], value: rri]]

    put(keys_values)
    stitch_plans
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

    keys_values = [[keys: [:to_account, :address], value: address]]

    put(keys_values)
    stitch_plans
  end

  def get do
    case Process.whereis(@agent) do
      nil -> %{}
      _ -> Agent.get(@agent, fn map -> map end)
    end
  end

  def stop do
    case Process.whereis(@agent) do
      nil -> {:error, "not running"}
      _ -> Agent.stop(@agent)
    end
  end

  defp put(keys_values) do
    if !Process.whereis(@agent) do
      Agent.start_link(fn -> %{} end, name: @agent)
    end

    Agent.update(@agent, fn content -> Util.stitch(keys_values, content) end)
  end
end
