defmodule Radixir.System do
  @moduledoc """
  Provides high level interaction with the System API.
  """

  alias Radixir.System.API
  @type options :: keyword()
  @type error_message :: String.t()

  @doc """
  Gets system version.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_version(options) :: {:ok, map} | {:error, map | error_message}
  defdelegate get_version(options \\ []), to: API

  @doc """
  Gets system health.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_health(options) :: {:ok, map} | {:error, map | error_message}
  defdelegate get_health(options \\ []), to: API

  @doc """
  Gets system configuration.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_configuration(options) :: {:ok, map} | {:error, map | error_message}
  defdelegate get_configuration(options \\ []), to: API

  @doc """
  Gets system peers.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_peers(options) :: {:ok, map} | {:error, map | error_message}
  defdelegate get_peers(options \\ []), to: API

  @doc """
  Gets system addressbook.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_address_book(options) :: {:ok, map} | {:error, map | error_message}
  defdelegate get_address_book(options \\ []), to: API

  @doc """
  Gets system metrics.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_metrics(options) :: {:ok, map} | {:error, map | error_message}
  defdelegate get_metrics(options \\ []), to: API

  @doc """
  Gets prometheus metrics.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_prometheus_metrics(options) :: {:ok, map} | {:error, map | error_message}
  defdelegate get_prometheus_metrics(options \\ []), to: API
end
