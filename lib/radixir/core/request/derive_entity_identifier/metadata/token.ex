defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.Token do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "Token"], [:metadata])
  end

  def symbol(stitch_plans, params) do
    StitchPlan.symbol(stitch_plans, params, [:metadata])
  end
end
