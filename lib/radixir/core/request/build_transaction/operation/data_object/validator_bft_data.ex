defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.ValidatorBFTdata do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `ValidatorBFTdata` map.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword)
  @type params :: keyword

  @doc """
  Generates stitch plan for `type` map in `ValidatorBFTdata` map. Value is set to `ValidatorBFTdata`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "ValidatorBFTdata"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `proposals_completed` map in `ValidatorBFTdata` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `proposals_completed` (required, integer): Proposals completed.
  """
  @spec proposals_completed(stitch_plans, params) :: stitch_plans
  def proposals_completed(stitch_plans, params) do
    schema = [
      proposals_completed: [
        type: :integer,
        required: true
      ]
    ]

    proposals_completed =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:proposals_completed)

    stitch_plan = [
      [keys: [:data, :data_object, :proposals_completed], value: proposals_completed]
    ]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `proposals_missed` map in `ValidatorBFTdata` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `proposals_missed` (required, integer): Proposals missed.
  """
  @spec proposals_missed(stitch_plans, params) :: stitch_plans
  def proposals_missed(stitch_plans, params) do
    schema = [
      proposals_missed: [
        type: :integer,
        required: true
      ]
    ]

    proposals_missed =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:proposals_missed)

    stitch_plan = [[keys: [:data, :data_object, :proposals_missed], value: proposals_missed]]

    stitch_plan ++ stitch_plans
  end
end
