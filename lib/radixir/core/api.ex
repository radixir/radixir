defmodule Radixir.Core.API do
  @moduledoc false
  # @moduledoc """
  # Submits requests to Core API.
  # """
  alias Radixir.Util
  alias Radixir.HTTP

  @type body :: map
  @type options :: keyword
  @type error_message :: String.t()

  @doc """
  Submits request to `/network/configuration`.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/network/configuration](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/network/paths/~1network~1configuration/post)
  """
  @spec get_network_configuration(options) :: {:ok, map} | {:error, map | error_message}
  def get_network_configuration(options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/network/configuration", %{}, options)
    end
  end

  @doc """
  Submits request to `/network/status`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/network/status](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/network/paths/~1network~1status/post)
  """
  @spec get_network_status(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_network_status(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/network/status", body, options)
    end
  end

  @doc """
  Submits request to `/entity`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/entity](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/entity/paths/~1entity/post)
  """
  @spec get_entity_information(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_entity_information(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/entity", body, options)
    end
  end

  @doc """
  Submits request to `/mempool`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/mempool](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/mempool/paths/~1mempool/post)
  """
  @spec get_mempool_transactions(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_mempool_transactions(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/mempool", body, options)
    end
  end

  @doc """
  Submits request to `/mempool/transaction`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/mempool/transaction](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/mempool/paths/~1mempool~1transaction/post)
  """
  @spec get_mempool_transaction(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_mempool_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/mempool/transaction", body, options)
    end
  end

  @doc """
  Submits request to `/transactions`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/transactions](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/transactions/paths/~1transactions/post)
  """
  @spec get_committed_transactions(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_committed_transactions(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/transactions", body, options)
    end
  end

  @doc """
  Submits request to `/construction/derive`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/construction/derive](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/construction/paths/~1construction~1derive/post)
  """
  @spec derive_entity_identifier(body, options) :: {:ok, map} | {:error, map | error_message}
  def derive_entity_identifier(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/derive", body, options)
    end
  end

  @doc """
  Submits request to `/construction/build`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/construction/build](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/construction/paths/~1construction~1build/post)
  """
  @spec build_transaction(body, options) :: {:ok, map} | {:error, map | error_message}
  def build_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/build", body, options)
    end
  end

  @doc """
  Submits request to `/construction/parse`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/construction/parse](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/construction/paths/~1construction~1parse/post)
  """
  @spec parse_transaction(body, options) :: {:ok, map} | {:error, map | error_message}
  def parse_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/parse", body, options)
    end
  end

  @doc """
  Submits request to `/construction/finalize`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/construction/finalize](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/construction/paths/~1construction~1finalize/post)
  """
  @spec finalize_transaction(body, options) :: {:ok, map} | {:error, map | error_message}
  def finalize_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/finalize", body, options)
    end
  end

  @doc """
  Submits request to `/construction/hash`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/construction/hash](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/construction/paths/~1construction~1hash/post)
  """
  @spec get_transaction_hash(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_transaction_hash(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/hash", body, options)
    end
  end

  @doc """
  Submits request to `/construction/submit`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/construction/submit](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/construction/paths/~1construction~1submit/post)
  """
  @spec submit_transaction(body, options) :: {:ok, map} | {:error, map | error_message}
  def submit_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/construction/submit", body, options)
    end
  end

  @doc """
  Submits request to `/key/list`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/key/list](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/key/paths/~1key~1list/post)
  """
  @spec get_public_keys(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_public_keys(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/key/list", body, options)
    end
  end

  @doc """
  Submits request to `/key/sign`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`
      - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
      - `username`: (optional, string): Username to be used for endpoint authentication.
      - `password`: (optional, string): Password to be used for endpoint authentication.

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

  ## Core API Documentation
    - [/key/sign](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt/1.1.0/radixdlt-core/radixdlt/src/main/java/com/radixdlt/api/core/api.yaml#tag/key/paths/~1key~1sign/post)
  """
  @spec sign_transaction(body, options) :: {:ok, map} | {:error, map | error_message}
  def sign_transaction(body, options \\ []) do
    with {:ok, username, password, options} <- Util.get_auth_from_options(options),
         {:ok, url, options} <- Util.get_url_from_options(options, :core) do
      auth = [auth: {username, password}]
      options = Keyword.merge(auth, options)
      HTTP.post(url, "/key/sign", body, options)
    end
  end
end
