defmodule Radixir.Core.OperationGroup do
  def create(operations, metadata) do
    %{
      operations: operations,
      metadata: metadata
    }
  end
end
