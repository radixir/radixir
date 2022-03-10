defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.RoundData do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `RoundData` map.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `RoundData` map. Value is set to `RoundData`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "RoundData"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `round` map in `RoundData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `round` (required, integer): Round.
  """
  @spec round(stitch_plans, params) :: stitch_plans
  def round(stitch_plans, params) do
    schema = [
      round: [
        type: :integer,
        required: true
      ]
    ]

    round =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:round)

    stitch_plan = [[keys: [:data, :data_object, :round], value: round]]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `timestamp` map in `RoundData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `timestamp` (required, integer): Timestamp.
  """
  @spec timestamp(stitch_plans, params) :: stitch_plans
  def timestamp(stitch_plans, params) do
    schema = [
      timestamp: [
        type: :integer,
        required: true
      ]
    ]

    timestamp =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:timestamp)

    stitch_plan = [[keys: [:data, :data_object, :timestamp], value: timestamp]]

    stitch_plan ++ stitch_plans
  end
end
