defmodule Crypto.Error do
  @moduledoc false
  defexception reason: nil

  def message(exception) do
    "Crypto.Error: #{exception.reason}"
  end
end
