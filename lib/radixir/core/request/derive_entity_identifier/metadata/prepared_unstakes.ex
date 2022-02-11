defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.PreparedUnstakes do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "PreparedUnstakes"], [:metadata])
  end
end
