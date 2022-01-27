defmodule Radixir.SystemAPI do
  alias Radixir.Config
  alias Radixir.HTTP

  def get_version() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/version",
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_health() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/health",
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_configuration() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/configuration",
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_peers() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/peers",
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_address_book() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/addressbook",
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_metrics() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/system/metrics",
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_prometheus_metrics() do
    HTTP.get(
      Config.radix_system_api_url(),
      "/prometheus/metrics",
      auth: {"metrics", Config.radix_metrics_password()}
    )
  end
end
