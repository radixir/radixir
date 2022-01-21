defmodule Radixir.SystemAPI do
  alias Radixir.Config
  alias Radixir.HTTP

  def get_version() do
    HTTP.get(Config.radix_system_api_url(), "/system/version")
  end

  def get_health() do
    HTTP.get(Config.radix_system_api_url(), "/system/health")
  end

  def get_configuration() do
    HTTP.get(Config.radix_system_api_url(), "/system/configuration")
  end

  def get_peers() do
    HTTP.get(Config.radix_system_api_url(), "/system/peers")
  end

  def get_address_book() do
    HTTP.get(Config.radix_system_api_url(), "/system/addressbook")
  end

  def get_metrics() do
    HTTP.get(Config.radix_system_api_url(), "/system/metrics")
  end

  def get_prometheus_metrics() do
    HTTP.get(Config.radix_system_api_url(), "/prometheus/metrics")
  end
end
