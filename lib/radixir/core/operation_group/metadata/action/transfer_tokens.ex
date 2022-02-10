defmodule Radixir.Core.OperationGroup.Metadata.Action.TransferTokens do
  alias Radixir.RequestPiece.Action.TransferTokens
  alias Radixir.RequestPiece.ResourceIdentifier.Token

  def type(stitch_plans) do
    TransferTokens.type(stitch_plans, [:metadata, :action])
  end

  def from(stitch_plans, params) do
    TransferTokens.from(stitch_plans, params, [:metadata, :action])
  end

  def to(stitch_plans, params) do
    TransferTokens.to(stitch_plans, params, [:metadata, :action])
  end

  def amount(stitch_plans, params) do
    TransferTokens.amount(stitch_plans, params, [:metadata, :action])
  end

  def resource_identifier(stitch_plans, params) do
    Token.resource_identifier(stitch_plans, params, [:metadata, :action, :amount])
  end
end
