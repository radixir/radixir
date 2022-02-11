defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.TokenMetaData do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "TokenMetaData"], [:data, :data_object])
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
    StitchPlan.name(stitch_plans, params, [:data, :data_object])
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
    StitchPlan.type(stitch_plans, params, [:data, :data_object])
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
