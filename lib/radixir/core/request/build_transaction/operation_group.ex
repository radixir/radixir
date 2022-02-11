defmodule Radixir.Core.Request.BuildTransaction.OperationGroup do
  def create(operations), do: %{operations: operations}
end
