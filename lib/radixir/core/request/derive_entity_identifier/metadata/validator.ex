defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.Validator do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "Validator"], [:metadata])
  end
end
