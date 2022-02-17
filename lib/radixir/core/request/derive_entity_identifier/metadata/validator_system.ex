defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.ValidatorSystem do
  @moduledoc """
  Methods to create each map in `ValidatorSystem` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())

  @doc """
  Generates stitch plan for `type` map in `ValidatorSystem` map. Value is set to `ValidatorSystem`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "ValidatorSystem"], [:metadata])
  end
end
