defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.ValidatorSystem do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "ValidatorSystem"], [:metadata])
  end
end
