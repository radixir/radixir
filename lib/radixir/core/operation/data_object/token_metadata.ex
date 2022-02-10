defmodule Radixir.Core.Operation.DataObject.TokenMetaData do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "TokenMetaData"], [:data, :data_object])
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

    stitch_plan = [[keys: [:data, :data_object, :symbol], value: symbol]]

    stitch_plan ++ stitch_plans
  end

  def name(stitch_plans, params) do
    schema = [
      name: [
        type: :string,
        required: true
      ]
    ]

    name =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:name)

    stitch_plan = [[keys: [:data, :data_object, :name], value: name]]

    stitch_plan ++ stitch_plans
  end

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

  def url(stitch_plans, params) do
    schema = [
      url: [
        type: :string,
        required: true
      ]
    ]

    url =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:url)

    stitch_plan = [[keys: [:data, :data_object, :url], value: url]]

    stitch_plan ++ stitch_plans
  end

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
