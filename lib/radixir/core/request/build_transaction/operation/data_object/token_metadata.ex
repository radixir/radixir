defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.TokenMetaData do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `TokenMetaData` map.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword)
  @type params :: keyword

  @doc """
  Generates stitch plan for `type` map in `TokenMetaData` map. Value is set to `TokenMetaData`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "TokenMetaData"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `symbol` map in `TokenMetaData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `symbol` (required, string): Symbol.
  """
  @spec symbol(stitch_plans, params) :: stitch_plans
  def symbol(stitch_plans, params) do
    StitchPlan.symbol(stitch_plans, params, [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `name` map in `TokenMetaData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `name` (required, string): Name.
  """
  @spec name(stitch_plans, params) :: stitch_plans
  def name(stitch_plans, params) do
    StitchPlan.name(stitch_plans, params, [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `description` map in `TokenMetaData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `description` (required, string): Description.
  """
  @spec description(stitch_plans, params) :: stitch_plans
  def description(stitch_plans, params) do
    schema = [
      description: [
        type: :string,
        required: true
      ]
    ]

    description =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:description)

    stitch_plan = [[keys: [:data, :data_object, :description], value: description]]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `url` map in `TokenMetaData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `url` (required, string): Url.
  """
  @spec url(stitch_plans, params) :: stitch_plans
  def url(stitch_plans, params) do
    StitchPlan.url(stitch_plans, params, [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `icon_url` map in `TokenMetaData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `icon_url` (required, string): Icon url.
  """
  @spec icon_url(stitch_plans, params) :: stitch_plans
  def icon_url(stitch_plans, params) do
    schema = [
      icon_url: [
        type: :string,
        required: true
      ]
    ]

    icon_url =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:icon_url)

    stitch_plan = [[keys: [:data, :data_object, :icon_url], value: icon_url]]

    stitch_plan ++ stitch_plans
  end
end
