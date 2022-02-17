defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.Account do
  @moduledoc """
  Methods to create each map in `Account` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `Account` map. Value is set to `Account`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "Account"], [:metadata])
  end
end
