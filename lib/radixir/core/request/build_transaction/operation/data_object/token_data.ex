defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.TokenData do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `TokenData` map.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword)
  @type params :: keyword

  @doc """
  Generates stitch plan for `type` map in `TokenData` map. Value is set to `TokenData`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "TokenData"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `granularity` map in `TokenData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `granularity` (required, string): Granularity.
  """
  @spec granularity(stitch_plans, params) :: stitch_plans
  def granularity(stitch_plans, params) do
    schema = [
      granularity: [
        type: :string,
        required: true
      ]
    ]

    granularity =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:granularity)

    stitch_plan = [[keys: [:data, :data_object, :granularity], value: granularity]]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `is_mutable` map in `TokenData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `is_mutable` (required, boolean): Is token mutable?.
  """
  @spec is_mutable(stitch_plans, params) :: stitch_plans
  def is_mutable(stitch_plans, params) do
    schema = [
      is_mutable: [
        type: :boolean,
        required: true
      ]
    ]

    is_mutable =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:is_mutable)

    stitch_plan = [[keys: [:data, :data_object, :is_mutable], value: is_mutable]]

    stitch_plan ++ stitch_plans
  end

  @doc """
  Generates stitch plan for `owner` map in `TokenData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Owner address.
  """
  @spec owner(stitch_plans, params) :: stitch_plans
  def owner(stitch_plans, params) do
    StitchPlan.owner(stitch_plans, params, [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `sub_entity` map in `TokenData` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `sub_entity_address` (required, string): Sub Entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
  """
  @spec sub_entity(stitch_plans, params) :: stitch_plans
  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:data, :data_object, :owner])
  end
end
