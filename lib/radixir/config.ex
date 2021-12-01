defmodule Radixir.Config do
  def radix_node_url do
    Application.fetch_env!(:radixir, :radix_node_url)
  end
end
