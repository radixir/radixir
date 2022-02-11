defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.PreparedStakes do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "PreparedStakes"], [:metadata])
  end

  def validator(stitch_plans, params) do
    StitchPlan.validator(stitch_plans, params, [:metadata])
  end

  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:metadata, :validator])
  end
end
