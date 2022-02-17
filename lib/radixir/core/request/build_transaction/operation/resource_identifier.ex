defmodule Radixir.Core.Request.BuildTransaction.Operation.ResourceIdentifier do
  @moduledoc """
  Methods to create each map in `ResourceIdentifier` map.
  """

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `token` type in `ResourceIdentifier` map. Type value is set to `Token`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `rri` (required, string): Radix Resource Identifier.
  """
  @spec token(stitch_plans, params) :: stitch_plans
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

    rri = [keys: [:amount, :resource_identifier, :rri], value: rri_value]
    type = [keys: [:amount, :resource_identifier, :type], value: "Token"]

    stitch_plan = [rri, type]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `stake_unit` type in `ResourceIdentifier` map. Type value is set to `StakeUnit`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `validator_address` (required, string): Radix address.
  """
  @spec stake_unit(stitch_plans, params) :: stitch_plans
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
      keys: [:amount, :resource_identifier, :validator_address],
      value: validator_address_value
    ]

    type = [keys: [:amount, :resource_identifier, :type], value: "StakeUnit"]

    stitch_plan = [validator_address, type]

    stitch_plan ++ stitch_plans
  end
end
