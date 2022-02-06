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

  def radix_system_api_url do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_system_api_url)
  end

  def radix_admin_username do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_admin_username)
  end

  def radix_admin_password do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_admin_password)
  end

  def radix_superadmin_username do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_superadmin_username)
  end

  def radix_superadmin_password do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_superadmin_password)
  end

  def radix_metrics_username do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_metrics_username)
  end

  def radix_metrics_password do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_metrics_password)
  end

  def radix_testnet? do
    :radixir
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:radix_testnet)
    |> case do
      "true" -> true
      _ -> false
    end
  end

  def network do
    if radix_testnet?() do
      "stokenet"
    else
      "mainnet"
    end
  end
end
