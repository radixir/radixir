defmodule Radixir.Config do
  def radix_gateway_api_url do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_gateway_api_url)
  end

  def radix_core_api_url do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_core_api_url)
  end
end
