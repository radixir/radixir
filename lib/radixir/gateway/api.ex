defmodule Radixir.Gateway.API do
  @moduledoc false
  # @moduledoc """
  # Submits requests to Gateway API.
  # """
  alias Radixir.Util
  alias Radixir.HTTP

  @type body :: map
  @type options :: keyword
  @type error_message :: String.t()

  @doc """
  Submits request to `/gateway`.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/gateway](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Status/paths/~1gateway/post)
  """
  @spec get_info(options) :: {:ok, map} | {:error, map | error_message}
  def get_info(options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/gateway", %{}, options)
    end
  end

  @doc """
  Submits request to `/account/derive`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/account/derive](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Account/paths/~1account~1derive/post)
  """
  @spec derive_account_identifier(body, options) :: {:ok, map} | {:error, map | error_message}
  def derive_account_identifier(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/account/derive", body, options)
    end
  end

  @doc """
  Submits request to `/account/balances`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/account/balances](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Account/paths/~1account~1balances/post)
  """
  @spec get_account_balances(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_account_balances(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/account/balances", body, options)
    end
  end

  @doc """
  Submits request to `/account/stakes`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/account/stakes](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Account/paths/~1account~1stakes/post)
  """
  @spec get_stake_positions(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_stake_positions(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/account/stakes", body, options)
    end
  end

  @doc """
  Submits request to `/account/unstakes`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/account/unstakes](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Account/paths/~1account~1unstakes/post)
  """
  @spec get_unstake_positions(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_unstake_positions(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/account/unstakes", body, options)
    end
  end

  @doc """
  Submits request to `/account/transactions`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/account/transactions](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Account/paths/~1account~1transactions/post)
  """
  @spec get_account_transactions(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_account_transactions(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/account/transactions", body, options)
    end
  end

  @doc """
  Submits request to `/token/native`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/token/native](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Token/paths/~1token~1native/post)
  """
  @spec get_native_token_info(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_native_token_info(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/token/native", body, options)
    end
  end

  @doc """
  Submits request to `/token`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/token](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Token/paths/~1token/post)
  """
  @spec get_token_info(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_token_info(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/token", body, options)
    end
  end

  @doc """
  Submits request to `/token/derive`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/token/derive](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Token/paths/~1token~1derive/post)
  """
  @spec derive_token_identifier(body, options) :: {:ok, map} | {:error, map | error_message}
  def derive_token_identifier(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/token/derive", body, options)
    end
  end

  @doc """
  Submits request to `/validator`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/validator](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Validator/paths/~1validator/post)
  """
  @spec get_validator(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_validator(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/validator", body, options)
    end
  end

  @doc """
  Submits request to `/validator/derive`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/validator/derive](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Validator/paths/~1validator~1derive/post)
  """
  @spec derive_validator_identifier(body, options) :: {:ok, map} | {:error, map | error_message}
  def derive_validator_identifier(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/validator/derive", body, options)
    end
  end

  @doc """
  Submits request to `/validators`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/validators](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Validator/paths/~1validators/post)
  """
  @spec get_validators(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_validators(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/validators", body, options)
    end
  end

  @doc """
  Submits request to `/validator/stakes`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/validator/stakes](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Validator/paths/~1validator~1stakes/post)
  """
  @spec get_validator_stakes(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_validator_stakes(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/validator/stakes", body, options)
    end
  end

  @doc """
  Submits request to `/transaction/rules`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/transaction/rules](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Transaction/paths/~1transaction~1rules/post)
  """
  @spec get_transaction_rules(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_transaction_rules(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/transaction/rules", body, options)
    end
  end

  @doc """
  Submits request to `/transaction/build`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/transaction/build](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Transaction/paths/~1transaction~1build/post)
  """
  @spec build_transaction(body, options) :: {:ok, map} | {:error, map | error_message}
  def build_transaction(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/transaction/build", body, options)
    end
  end

  @doc """
  Submits request to `/transaction/finalize`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/transaction/finalize](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Transaction/paths/~1transaction~1finalize/post)
  """
  @spec finalize_transaction(body, options) :: {:ok, map} | {:error, map | error_message}
  def finalize_transaction(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/transaction/finalize", body, options)
    end
  end

  @doc """
  Submits request to `/transaction/submit`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/transaction/submit](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Transaction/paths/~1transaction~1submit/post)
  """
  @spec submit_transaction(body, options) :: {:ok, map} | {:error, map | error_message}
  def submit_transaction(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/transaction/submit", body, options)
    end
  end

  @doc """
  Submits request to `/transaction/status`.

  ## Parameters
    - `body`: Request body.
    - `options`: Keyword list that contains
      - `url` (optional, string): If url is not in options then the url set in the configs will be used.
      - any other options one may want to pass along to the http layer - for example `headers`

  ## Gateway API Documentation
    - [/transaction/status](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/radixdlt/radixdlt-network-gateway/1.1.1/gateway-api-spec.yaml#tag/Transaction/paths/~1transaction~1status/post)
  """
  @spec get_transaction_status(body, options) :: {:ok, map} | {:error, map | error_message}
  def get_transaction_status(body, options \\ []) do
    with {:ok, url, options} <- Util.get_url_from_options(options, :gateway) do
      HTTP.post(url, "/transaction/status", body, options)
    end
  end
end
