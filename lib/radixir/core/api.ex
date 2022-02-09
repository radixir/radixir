defmodule Radixir.Core.API do
  alias Radixir.HTTP
  alias Radixir.Util

  def get_network_configuration(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/network/configuration", %{}, options)
    end
  end

  def get_network_status(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/network/status", body, options)
    end
  end

  def get_entity_information(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/entity", body, options)
    end
  end

  def get_mempool_transactions(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/mempool", body, options)
    end
  end

  def get_mempool_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/mempool/transaction", body, options)
    end
  end

  def get_committed_transactions(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/transactions", body, options)
    end
  end

  def derive_entity_identifier(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/derive", body, options)
    end
  end

  def build_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/build", body, options)
    end
  end

  def parse_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/parse", body, options)
    end
  end

  def finalize_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/finalize", body, options)
    end
  end

  def get_transaction_hash(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/hash", body, options)
    end
  end

  def submit_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/submit", body, options)
    end
  end

  def get_public_keys(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/key/list", body, options)
    end
  end

  def sign_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {url, options} <- Util.get_url_from_options(options) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/key/sign", body, options)
    end
  end
end
