defmodule Radixir.Core.Request.BuildTransaction.OperationGroup do
  @moduledoc false
  # @moduledoc """
  # Method to create an operation group map.
  # """

  @type operations :: list(map)

  @spec create(operations) :: map
  def create(operations), do: %{operations: operations}
end
