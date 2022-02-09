defmodule Radixir.System.API do
  alias Radixir.HTTP
  alias Radixir.Util

  def get_version(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/version", options)
    end
  end

  def get_health(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/health", options)
    end
  end

  def get_configuration(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/configuration", options)
    end
  end

  def get_peers(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/peers", options)
    end
  end

  def get_address_book(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/addressbook", options)
    end
  end

  def get_metrics(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/metrics", options)
    end
  end

  def get_prometheus_metrics(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/prometheus/metrics", options)
    end
  end
end
