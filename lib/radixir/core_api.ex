defmodule Radixir.CoreAPI do
  alias Radixir.HTTP

  def get_network_configuration(url, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/network/configuration", %{}, options)
  end

  def get_network_status(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/network/status", body, options)
  end

  def get_entity_information(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/entity", body, options)
  end

  def get_mempool_transactions(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/mempool", body, options)
  end

  def get_mempool_transaction(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/mempool/transaction", body, options)
  end

  def get_committed_transactions(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/transactions", body, options)
  end

  def derive_entity_identifier(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/construction/derive", body, options)
  end

  def build_transaction(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/construction/build", body, options)
  end

  def parse_transaction(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/construction/parse", body, options)
  end

  def finalize_transaction(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/construction/finalize", body, options)
  end

  def get_transaction_hash(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/construction/hash", body, options)
  end

  def submit_transaction(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/construction/submit", body, options)
  end

  def get_public_keys(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/key/list", body, options)
  end

  def sign_transaction(url, body, username, password, options \\ []) do
    auth = [auth: {username, password}]
    options = Keyword.merge(auth, options)
    HTTP.post(url, "/key/sign", body, options)
  end
end
