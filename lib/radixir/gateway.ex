defmodule Radixir.Gateway do
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

    stitch_plan = [keys: [:network_identifier, :network], value: network]

    [stitch_plan | stitch_plans]
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

    stitch_plan = [keys: [:public_key, :hex], value: hex]

    [stitch_plan | stitch_plans]
  end
end
