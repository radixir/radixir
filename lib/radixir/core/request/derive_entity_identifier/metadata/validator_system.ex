defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.ValidatorSystem do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "ValidatorSystem"], [:metadata])
  end
end
