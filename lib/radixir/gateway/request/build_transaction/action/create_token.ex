defmodule Radixir.Gateway.Request.BuildTransaction.Action.CreateToken do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `CreateToken` action.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `CreateToken` action. Value is set to `CreateTokenDefinition`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, type: "CreateTokenDefinition")
  end

  @doc """
  Generates stitch plan for `token_properties` map in `CreateToken` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `name` (required, string): Token name
      - `description` (required, string): Token description.
      - `icon_url` (required, string): Token icon url.
      - `url` (required, string): Token url.
      - `symbol` (required, string): Token symbol.
      - `is_supply_mutable` (required, boolean): Is token supply mutaable?
      - `granularity` (required, string): Token granularity.
  """
  @spec token_properties(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `owner` map in `CreateToken` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Owner address.
  """
  @spec owner(stitch_plans, params) :: stitch_plans
  def owner(stitch_plans, params) do
    StitchPlan.owner(stitch_plans, params, [:token_properties])
  end

  @doc """
  Generates stitch plan for `token_supply` map in `CreateToken` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `value` (required, string): Token supply value.
  """
  @spec token_supply(stitch_plans, params) :: stitch_plans
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

  @doc """
  Generates stitch plan for `token_identifier` map in `CreateToken` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `rri` (required, string): Radix Resource Identifier.
  """
  @spec token_identifier(stitch_plans, params) :: stitch_plans
  def token_identifier(stitch_plans, params) do
    StitchPlan.token_identifier(stitch_plans, params, [:token_supply])
  end

  @doc """
  Generates stitch plan for `to_account` map in `CreateToken` action.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec to_account(stitch_plans, params) :: stitch_plans
  defdelegate to_account(stitch_plans, params), to: StitchPlan
end
