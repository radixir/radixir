defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.Validator do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `Validator` map.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword)

  @doc """
  Generates stitch plan for `type` map in `Validator` map. Value is set to `Validator`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "Validator"], [:metadata])
  end
end
