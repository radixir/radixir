defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.Validator do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "Validator"], [:metadata])
  end
end
