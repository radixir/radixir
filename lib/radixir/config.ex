defmodule Radixir.Config do
  def radix_node_url do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_node_url)
  end

  def keypairs_file_name do
    file_name =
      :radixir
      |> Application.fetch_env!(__MODULE__)
      |> Keyword.fetch!(:keypairs_file_name)

    file_name <> ".json"
  end
end
