defmodule Radixir.Core.OperationGroup do
  def create(operations, metadata) do
    %{
      operations: operations,
      # TODO: figure out what goes here
      metadata: metadata
    }
  end
end
