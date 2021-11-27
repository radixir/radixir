defmodule Radixir do
  alias Radixir.HTTP

  def get_native_token(id \\ nil) do
    HTTP.call("/archive", "tokens.get_native_token", %{}, id)
  end

  def get_token_info(rri, id \\ nil) do
    HTTP.call("/archive", "tokens.get_info", %{rri: rri}, id)
  end
end
