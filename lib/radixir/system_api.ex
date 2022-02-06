defmodule Radixir.SystemAPI do
  alias Radixir.HTTP

  def get_version(url, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.get(url, "/system/version", options)
  end

  def get_health(url, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.get(url, "/system/health", options)
  end

  def get_configuration(url, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.get(url, "/system/configuration", options)
  end

  def get_peers(url, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.get(url, "/system/peers", options)
  end

  def get_address_book(url, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.get(url, "/system/addressbook", options)
  end

  def get_metrics(url, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.get(url, "/system/metrics", options)
  end

  def get_prometheus_metrics(url, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.get(url, "/prometheus/metrics", options)
  end
end
