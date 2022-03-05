defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.ExitingUnstakes do
  @moduledoc """
  Methods to create each map in `ExitingUnstakes` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `ExitingUnstakes` map. Value is set to `ExitingUnstakes`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "ExitingUnstakes"], [:metadata])
  end

  @doc """
  Generates stitch plan for `validator` map in `ExitingUnstakes` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Validator address.
  """
  @spec validator(stitch_plans, params) :: stitch_plans
  def validator(stitch_plans, params) do
    StitchPlan.validator(stitch_plans, params, [:metadata])
  end

  @doc """
  Generates stitch plan for `sub_entity` map in `ExitingUnstakes` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `sub_entity_address` (required, string): Sub Entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
  """
  @spec sub_entity(stitch_plans, params) :: stitch_plans
  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:metadata, :validator])
  end

  @doc """
  Generates stitch plan for `epoch_unlock` map in `ExitingUnstakes` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `epoch_unlock` (required, integer): Epoch unlock.
  """
  @spec epoch_unlock(stitch_plans, params) :: stitch_plans
  def epoch_unlock(stitch_plans, params) do
    schema = [
      epoch_unlock: [
        type: :integer,
        required: true
      ]
    ]

    epoch_unlock =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:epoch_unlock)

    stitch_plan = [[keys: [:metadata, :epoch_unlock], value: epoch_unlock]]

    stitch_plan ++ stitch_plans
  end
end
