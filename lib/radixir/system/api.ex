defmodule Radixir.System.API do
  @moduledoc false
  # @moduledoc """
  # Submits requests to System API.
  # """
  alias Radixir.Util
  alias Radixir.HTTP

  @type options :: keyword()
  @type error_message :: String.t()

  @doc """
  Submits request to `/system/version`.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  ## Example

  If the following usernames and passwords are exported:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then passing `auth_index: 0` would lead to `admin` being used as the `username` and `funny cats very Jack 21!` being used as the `password` for endpoint authentication.

  ## System API Documentation
    - [/system/version](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/system/api.yaml#/paths/~1system~1version/get)
  """
  @spec get_version(options) :: {:ok, map} | {:error, map | error_message}
  def get_version(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/version", options)
    end
  end

  @doc """
  Submits request to `/system/health`.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  ## Example

  If the following usernames and passwords are exported:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then passing `auth_index: 0` would lead to `admin` being used as the `username` and `funny cats very Jack 21!` being used as the `password` for endpoint authentication.

  ## System API Documentation
    - [/system/health](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/system/api.yaml#/paths/~1system~1health/get)
  """
  @spec get_health(options) :: {:ok, map} | {:error, map | error_message}
  def get_health(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/health", options)
    end
  end

  @doc """
  Submits request to `/system/configuration`.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  ## Example

  If the following usernames and passwords are exported:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then passing `auth_index: 0` would lead to `admin` being used as the `username` and `funny cats very Jack 21!` being used as the `password` for endpoint authentication.

  ## System API Documentation
    - [/system/configuration](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/system/api.yaml#/paths/~1system~1configuration/get)
  """
  @spec get_configuration(options) :: {:ok, map} | {:error, map | error_message}
  def get_configuration(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/configuration", options)
    end
  end

  @doc """
  Submits request to `/system/peers`.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  ## Example

  If the following usernames and passwords are exported:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then passing `auth_index: 0` would lead to `admin` being used as the `username` and `funny cats very Jack 21!` being used as the `password` for endpoint authentication.

  ## System API Documentation
    - [/system/peers](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/system/api.yaml#/paths/~1system~1peers/get)
  """
  @spec get_peers(options) :: {:ok, map} | {:error, map | error_message}
  def get_peers(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/peers", options)
    end
  end

  @doc """
  Submits request to `/system/addressbook`.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  ## Example

  If the following usernames and passwords are exported:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then passing `auth_index: 0` would lead to `admin` being used as the `username` and `funny cats very Jack 21!` being used as the `password` for endpoint authentication.

  ## System API Documentation
    - [/system/addressbook](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/system/api.yaml#/paths/~1system~1addressbook/get)
  """
  @spec get_address_book(options) :: {:ok, map} | {:error, map | error_message}
  def get_address_book(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/addressbook", options)
    end
  end

  @doc """
  Submits request to `/system/metrics`.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  ## Example

  If the following usernames and passwords are exported:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then passing `auth_index: 0` would lead to `admin` being used as the `username` and `funny cats very Jack 21!` being used as the `password` for endpoint authentication.

  ## System API Documentation
    - [/system/metrics](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/system/api.yaml#/paths/~1system~1metrics/get)
  """
  @spec get_metrics(options) :: {:ok, map} | {:error, map | error_message}
  def get_metrics(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/system/metrics", options)
    end
  end

  @doc """
  Submits request to `/prometheus/metrics`.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): `username` to be used for endpoint authentication.
      - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.

  ## Example

  If the following usernames and passwords are exported:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then passing `auth_index: 0` would lead to `admin` being used as the `username` and `funny cats very Jack 21!` being used as the `password` for endpoint authentication.

  ## System API Documentation
    - [/prometheus/metrics](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/system/api.yaml#/paths/~1prometheus~1metrics/get)
  """
  @spec get_prometheus_metrics(options) :: {:ok, map} | {:error, map | error_message}
  def get_prometheus_metrics(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :system) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.get(url, "/prometheus/metrics", options)
    end
  end
end
