defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.Account do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "Account"], [:metadata])
  end
end
