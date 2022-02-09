defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.Token do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "Token"], [:metadata])
  end

  def symbol(stitch_plans, params) do
    RequestPiece.symbol(stitch_plans, params, [:metadata])
  end
end
