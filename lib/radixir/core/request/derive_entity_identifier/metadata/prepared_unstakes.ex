defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.PreparedUnstakes do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "PreparedUnstakes"], [:metadata])
  end
end
