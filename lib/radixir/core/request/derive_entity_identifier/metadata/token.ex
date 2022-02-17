defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.Token do
  @moduledoc """
  Methods to create each map in `Token` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `Token` map. Value is set to `Token`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "Token"], [:metadata])
  end

  @doc """
  Generates stitch plan for `symbol` map in `Token` ma.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `symbol` (required, string): Symbol.
  """
  @spec symbol(stitch_plans, params) :: stitch_plans
  def symbol(stitch_plans, params) do
    StitchPlan.symbol(stitch_plans, params, [:metadata])
  end
end
