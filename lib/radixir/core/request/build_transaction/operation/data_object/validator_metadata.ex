defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.ValidatorMetadata do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `ValidatorMetadata` map.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword)
  @type params :: keyword

  @doc """
  Generates stitch plan for `type` map in `ValidatorMetadata` map. Value is set to `ValidatorMetadata`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "ValidatorMetadata"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `name` map in `ValidatorMetadata` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `name` (required, string): Name.
  """
  @spec name(stitch_plans, params) :: stitch_plans
  def name(stitch_plans, params) do
    StitchPlan.name(stitch_plans, params, [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `url` map in `ValidatorMetadata` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `url` (required, string): Url.
  """
  @spec url(stitch_plans, params) :: stitch_plans
  def url(stitch_plans, params) do
    StitchPlan.url(stitch_plans, params, [:data, :data_object])
  end
end
