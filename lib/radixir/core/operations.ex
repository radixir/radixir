defmodule Radixir.Core.OperationGroup do
  def new(operations, metadata) do
    %{
      operations: operations,
      metadata: metadata
    }
  end
end
