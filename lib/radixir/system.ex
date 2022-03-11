defmodule Radixir.System do
  @moduledoc """
  Provides high level interaction with the System API.
  """

  alias Radixir.System.API

  @type options :: keyword
  @type error_message :: String.t()

  @doc """
  Gets system version.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  If the following usernames and passwords are exported as follows:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then an `auth_index` of 0 would result in `admin` being used as the username and `funny cats very Jack 21!` being used as the password.
  """
  @spec get_version(options) :: {:ok, map} | {:error, map | error_message}
  def get_version(options \\ []), do: API.get_version(options)

  @doc """
  Gets system health.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  If the following usernames and passwords are exported as follows:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then an `auth_index` of 0 would result in `admin` being used as the username and `funny cats very Jack 21!` being used as the password.
  """
  @spec get_health(options) :: {:ok, map} | {:error, map | error_message}
  def get_health(options \\ []), do: API.get_health(options)

  @doc """
  Gets system configuration.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  If the following usernames and passwords are exported as follows:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then an `auth_index` of 0 would result in `admin` being used as the username and `funny cats very Jack 21!` being used as the password.
  """
  @spec get_configuration(options) :: {:ok, map} | {:error, map | error_message}
  def get_configuration(options \\ []), do: API.get_configuration(options)

  @doc """
  Gets system peers.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  If the following usernames and passwords are exported as follows:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then an `auth_index` of 0 would result in `admin` being used as the username and `funny cats very Jack 21!` being used as the password.
  """
  @spec get_peers(options) :: {:ok, map} | {:error, map | error_message}
  def get_peers(options \\ []), do: API.get_peers(options)

  @doc """
  Gets system addressbook.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  If the following usernames and passwords are exported as follows:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then an `auth_index` of 0 would result in `admin` being used as the username and `funny cats very Jack 21!` being used as the password.
  """
  @spec get_address_book(options) :: {:ok, map} | {:error, map | error_message}
  def get_address_book(options \\ []), do: API.get_address_book(options)

  @doc """
  Gets system metrics.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  If the following usernames and passwords are exported as follows:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then an `auth_index` of 0 would result in `admin` being used as the username and `funny cats very Jack 21!` being used as the password.
  """
  @spec get_metrics(options) :: {:ok, map} | {:error, map | error_message}
  def get_metrics(options \\ []), do: API.get_metrics(options)

  @doc """
  Gets prometheus metrics.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  If the following usernames and passwords are exported as follows:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then an `auth_index` of 0 would result in `admin` being used as the username and `funny cats very Jack 21!` being used as the password.
  """
  @spec get_prometheus_metrics(options) :: {:ok, map} | {:error, map | error_message}
  def get_prometheus_metrics(options \\ []), do: API.get_prometheus_metrics(options)
end
