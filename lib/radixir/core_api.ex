defmodule Radixir.CoreAPI do
  alias Radixir.HTTP

  def get_network_configuration(url, username, password) do
    HTTP.post(url, "/network/configuration", %{}, auth: {username, password})
  end

  def get_network_status(url, body, username, password) do
    HTTP.post(url, "/network/status", body, auth: {username, password})
  end

  def get_entity_information(url, body, username, password) do
    HTTP.post(url, "/entity", body, auth: {username, password})
  end

  def get_mempool_transactions(url, body, username, password) do
    HTTP.post(url, "/mempool", body, auth: {username, password})
  end

  def get_mempool_transaction(url, body, username, password) do
    HTTP.post(url, "/mempool/transaction", body, auth: {username, password})
  end

  def get_committed_transactions(url, body, username, password) do
    HTTP.post(url, "/transactions", body, auth: {username, password})
  end

  def derive_entity_identifier(url, body, username, password) do
    HTTP.post(url, "/construction/derive", body, auth: {username, password})
  end

  def build_transaction(url, body, username, password) do
    HTTP.post(url, "/construction/build", body, auth: {username, password})
  end

  def parse_transaction(url, body, username, password) do
    HTTP.post(url, "/construction/parse", body, auth: {username, password})
  end

  def finalize_transaction(url, body, username, password) do
    HTTP.post(url, "/construction/finalize", body, auth: {username, password})
  end

  def get_transaction_hash(url, body, username, password) do
    HTTP.post(url, "/construction/hash", body, auth: {username, password})
  end

  def submit_transaction(url, body, username, password) do
    HTTP.post(url, "/construction/submit", body, auth: {username, password})
  end

  def get_public_keys(url, body, username, password) do
    HTTP.post(url, "/key/list", body, auth: {username, password})
  end

  def sign_transaction(url, body, username, password) do
    HTTP.post(url, "/key/sign", body, auth: {username, password})
  end
end
