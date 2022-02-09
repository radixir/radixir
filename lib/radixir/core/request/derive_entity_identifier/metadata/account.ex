defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.Account do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "Account"], [:metadata])
  end
end
