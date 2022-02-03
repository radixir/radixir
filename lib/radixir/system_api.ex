defmodule Radixir.SystemAPI do
  alias Radixir.HTTP

  def get_version(url, username, password) do
    HTTP.get(url, "/system/version", auth: {username, password})
  end

  def get_health(url, username, password) do
    HTTP.get(url, "/system/health", auth: {username, password})
  end

  def get_configuration(url, username, password) do
    HTTP.get(url, "/system/configuration", auth: {username, password})
  end

  def get_peers(url, username, password) do
    HTTP.get(url, "/system/peers", auth: {username, password})
  end

  def get_address_book(url, username, password) do
    HTTP.get(url, "/system/addressbook", auth: {username, password})
  end

  def get_metrics(url, username, password) do
    HTTP.get(url, "/system/metrics", auth: {username, password})
  end

  def get_prometheus_metrics(url, username, password) do
    HTTP.get(url, "/prometheus/metrics", auth: {username, password})
  end
end
