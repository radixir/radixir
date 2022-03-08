defmodule Radixir.Crypto.Error do
  @moduledoc false
  defexception reason: nil

  def message(exception) do
    "Radixir.Crypto.Error: #{exception.reason}"
  end
end
