defmodule Radixir.SystemAPI do
  alias Radixir.Config
  alias Radixir.HTTP

  def get_version() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/version",
      {"admin", Config.radix_admin_password()}
    )
  end

  def get_health() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/health",
      {"admin", Config.radix_admin_password()}
    )
  end

  def get_configuration() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/configuration",
      {"admin", Config.radix_admin_password()}
    )
  end

  def get_peers() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/peers",
      {"admin", Config.radix_admin_password()}
    )
  end

  def get_address_book() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/addressbook",
      {"admin", Config.radix_admin_password()}
    )
  end

  def get_metrics() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/metrics",
      {"admin", Config.radix_admin_password()}
    )
  end

  def get_prometheus_metrics() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/prometheus/metrics",
      {"metrics", Config.radix_metrics_password()}
    )
  end
end
