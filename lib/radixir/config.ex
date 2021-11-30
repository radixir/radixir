defmodule Radixir.Config do
  def radix_node_url do
    Application.fetch_env!(:radixir, :radix_node_url)
  end

  def private_keys do
    Application.fetch_env!(:radixir, :private_keys)
  end
end
