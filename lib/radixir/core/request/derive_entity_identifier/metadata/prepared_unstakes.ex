defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.PreparedUnstakes do
  @moduledoc """
  Methods to create each map in `PreparedUnstakes` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())

  @doc """
  Generates stitch plan for `type` map in `PreparedUnstakes` map. Value is set to `PreparedUnstakes`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "PreparedUnstakes"], [:metadata])
  end
end
