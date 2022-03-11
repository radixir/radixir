defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.PreparedStakes do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `PreparedStakes` map.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword)
  @type params :: keyword

  @doc """
  Generates stitch plan for `type` map in `PreparedStakes` map. Value is set to `PreparedStakes`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "PreparedStakes"], [:metadata])
  end

  @doc """
  Generates stitch plan for `validator` map in `PreparedStakes` map.

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
  Generates stitch plan for `sub_entity` map in `PreparedStakes` ma.

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
end
