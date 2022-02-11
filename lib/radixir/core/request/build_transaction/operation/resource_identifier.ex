defmodule Radixir.Core.Request.BuildTransaction.Operation.ResourceIdentifier do
  def token(stitch_plans, params) do
    schema = [
      rri: [
        type: :string,
        required: true
      ]
    ]

    rri_value =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:rri)

    rri = [keys: [:resource_identifier, :rri], value: rri_value]
    type = [keys: [:resource_identifier, :type], value: "Token"]

    stitch_plan = [rri, type]

    stitch_plan ++ stitch_plans
  end

  def stake_unit(stitch_plans, params) do
    schema = [
      validator_address: [
        type: :string,
        required: true
      ]
    ]

    validator_address_value =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:validator_address)

    validator_address = [
      keys: [:resource_identifier, :validator_address],
      value: validator_address_value
    ]

    type = [keys: [:resource_identifier, :type], value: "StakeUnit"]

    stitch_plan = [validator_address, type]

    stitch_plan ++ stitch_plans
  end
end
