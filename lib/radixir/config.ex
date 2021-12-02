defmodule Radixir.Config do
  def radix_node_url do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_node_url)
  end
end
