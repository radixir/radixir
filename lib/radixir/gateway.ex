defmodule Radixir.Gateway do
  @moduledoc """
  Provides high level interaction with the Gateway API.
  """

  alias Radixir.Gateway.API
  alias Radixir.Gateway.Request
  alias Radixir.Key
  alias Radixir.Util

  @type public_key :: String.t()
  @type private_key :: String.t()
  @type address :: String.t()
  @type rri :: String.t()
  @type symbol :: String.t()
  @type options :: keyword
  @type error_message :: String.t()
  @type unsigned_transaction :: String.t()
  @type signed_transaction :: String.t()
  @type signature_bytes :: String.t()
  @type signature_public_key :: String.t()
  @type transaction_hash :: String.t()
  @type fee_payer_address :: String.t()
  @type validator_address :: String.t()
  @type create_token_params :: %{
          name: String.t(),
          description: String.t(),
          icon_url: String.t(),
          url: String.t(),
          symbol: String.t(),
          is_supply_mutable: boolean,
          granularity: String.t(),
          owner_address: String.t(),
          token_supply: String.t(),
          token_rri: String.t(),
          to_account_address: String.t()
        }
  @type transfer_tokens_params :: %{
          from_address: String.t(),
          to_address: String.t(),
          amount: String.t(),
          token_rri: String.t()
        }
  @type stake_tokens_params :: %{
          from_address: String.t(),
          to_validator_address: String.t(),
          amount: String.t(),
          token_rri: String.t()
        }
  @type unstake_tokens_params :: %{
          from_validator_address: String.t(),
          to_address: String.t(),
          token_rri: String.t()
        }
  @type mint_tokens_params :: %{
          to_address: String.t(),
          amount: String.t(),
          token_rri: String.t()
        }
  @type burn_tokens_params :: %{
          from_address: String.t(),
          amount: String.t(),
          token_rri: String.t()
        }

  @doc """
  Gets the Gateway API version, network and current ledger state.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
  """
  def get_info(options \\ []), do: API.get_info(Keyword.get(options, :api, []))

  @doc """
  Gets the account address associated with the given public key.

  ## Parameters
    - `public_key`: Public key
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec derive_account_identifier(public_key, options) ::
          {:ok, map} | {:error, map | error_message}
  def derive_account_identifier(public_key, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.DeriveAccountIdentifier.network_identifier(network)
      |> Request.DeriveAccountIdentifier.public_key(hex: public_key)
      |> Util.stitch()

    API.derive_account_identifier(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets an account's available and staked token balances.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_account_balances(address, options) ::
          {:ok, map} | {:error, map | error_message}
  def get_account_balances(address, options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetAccountBalances.network_identifier(network)
      |> Request.GetAccountBalances.account_identifier(address: address)
      |> Request.GetAccountBalances.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_account_balances(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets the xrd which the account has in pending and active delegated stake positions with validators.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_stake_positions(address, options) ::
          {:ok, map} | {:error, map | error_message}
  def get_stake_positions(address, options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetStakePositions.network_identifier(network)
      |> Request.GetStakePositions.account_identifier(address: address)
      |> Request.GetStakePositions.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_stake_positions(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets the xrd which the account has in pending and temporarily-locked delegated unstake positions with validators.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_unstake_positions(address, options) ::
          {:ok, map} | {:error, map | error_message}
  def get_unstake_positions(address, options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetUnstakePositions.network_identifier(network)
      |> Request.GetUnstakePositions.account_identifier(address: address)
      |> Request.GetUnstakePositions.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_unstake_positions(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets user-initiated transactions involving the given account address which have been succesfully committed to the ledger.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_account_transactions(address, options) ::
          {:ok, map} | {:error, map | error_message}
  def get_account_transactions(address, options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    cursor = Keyword.take(options, [:cursor])

    limit = Keyword.take(options, [:limit])

    body =
      []
      |> Request.GetAccountTransactions.network_identifier(network)
      |> Request.GetAccountTransactions.account_identifier(address: address)
      |> Request.GetAccountTransactions.at_state_identifier(at_state_identifier)
      |> Util.maybe_create_stitch_plan(cursor, &Request.GetAccountTransactions.cursor/2)
      |> Util.maybe_create_stitch_plan(limit, &Request.GetAccountTransactions.limit/2)
      |> Util.stitch()

    API.get_account_transactions(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets information about xrd, including its Radix Resource Identifier.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_native_token_info(options) ::
          {:ok, map} | {:error, map | error_message}
  def get_native_token_info(options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetNativeTokenInfo.network_identifier(network)
      |> Request.GetNativeTokenInfo.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_native_token_info(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets information about any token, given its Radix Resource Identifier.

  ## Parameters
    - `rri`: Radix Resource Identifier
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_token_info(rri, options) ::
          {:ok, map} | {:error, map | error_message}
  def get_token_info(rri, options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetTokenInfo.network_identifier(network)
      |> Request.GetTokenInfo.token_identifier(rri: rri)
      |> Request.GetTokenInfo.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_token_info(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets the Radix Resource Identifier of a token with the given symbol, created by an account with the given public key.

  ## Parameters
    - `public_key`: Public key
    - `symbol`: Token symbol
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec derive_token_identifier(public_key, symbol, options) ::
          {:ok, map} | {:error, map | error_message}
  def derive_token_identifier(public_key, symbol, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.DeriveTokenIdentifier.network_identifier(network)
      |> Request.DeriveTokenIdentifier.public_key(hex: public_key)
      |> Request.DeriveTokenIdentifier.symbol(symbol: symbol)
      |> Util.stitch()

    API.derive_token_identifier(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets information about a validator, given a validator address.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_validator(address, options) ::
          {:ok, map} | {:error, map | error_message}
  def get_validator(address, options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetValidator.network_identifier(network)
      |> Request.GetValidator.validator_identifier(address: address)
      |> Request.GetValidator.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_validator(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets the validator address associated with the given public key.

  ## Parameters
    - `public_key`: Public key
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec derive_validator_identifier(public_key, options) ::
          {:ok, map} | {:error, map | error_message}
  def derive_validator_identifier(public_key, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.DeriveValidatorIdentifier.network_identifier(network)
      |> Request.DeriveValidatorIdentifier.public_key(hex: public_key)
      |> Util.stitch()

    API.derive_validator_identifier(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets information about all validators.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_validators(options) ::
          {:ok, map} | {:error, map | error_message}
  def get_validators(options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetValidators.network_identifier(network)
      |> Request.GetValidators.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_validators(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets paginated results about the delegated stakes from accounts to a validator.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_validator_stakes(address, options) ::
          {:ok, map} | {:error, map | error_message}
  def get_validator_stakes(address, options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    cursor = Keyword.take(options, [:cursor])

    limit = Keyword.take(options, [:limit])

    body =
      []
      |> Request.GetValidatorStakes.network_identifier(network)
      |> Request.GetValidatorStakes.validator_identifier(address: address)
      |> Request.GetValidatorStakes.at_state_identifier(at_state_identifier)
      |> Util.maybe_create_stitch_plan(cursor, &Request.GetValidatorStakes.cursor/2)
      |> Util.maybe_create_stitch_plan(limit, &Request.GetValidatorStakes.limit/2)
      |> Util.stitch()

    API.get_validator_stakes(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets the current rules used to build and validate transactions in the Radix Engine.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_transaction_rules(options) ::
          {:ok, map} | {:error, map | error_message}
  def get_transaction_rules(options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetValidatorStakes.network_identifier(network)
      |> Request.GetValidatorStakes.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_transaction_rules(body, Keyword.get(options, :api, []))
  end

  @doc """
  Builds a transaction of one or more create token actions.

  ## Parameters
    - `create_token_params_list`: List of create token params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec build_create_token_transaction(list(create_token_params), fee_payer_address, options) ::
          {:ok, map} | {:error, map | error_message}
  def build_create_token_transaction(create_token_params_list, fee_payer_address, options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    message = Keyword.take(options, [:message])

    disable_token_mint_and_burn = Keyword.take(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(create_token_params_list, fn x ->
        []
        |> Request.BuildTransaction.Action.CreateToken.type()
        |> Request.BuildTransaction.Action.CreateToken.token_properties(
          name: x.name,
          description: x.description,
          icon_url: x.icon_url,
          url: x.url,
          symbol: x.symbol,
          is_supply_mutable: x.is_supply_mutable,
          granularity: x.granularity
        )
        |> Request.BuildTransaction.Action.CreateToken.owner(address: x.owner_address)
        |> Request.BuildTransaction.Action.CreateToken.token_supply(value: x.token_supply)
        |> Request.BuildTransaction.Action.CreateToken.token_identifier(rri: x.token_rri)
        |> Request.BuildTransaction.Action.CreateToken.to_account(address: x.to_account_address)
        |> Util.stitch()
      end)

    body =
      []
      |> Request.BuildTransaction.network_identifier(network)
      |> Request.BuildTransaction.at_state_identifier(at_state_identifier)
      |> Request.BuildTransaction.fee_payer(address: fee_payer_address)
      |> Util.maybe_create_stitch_plan(message, &Request.BuildTransaction.message/2)
      |> Util.maybe_create_stitch_plan(
        disable_token_mint_and_burn,
        &Request.BuildTransaction.disable_token_mint_and_burn/2
      )
      |> Util.stitch()

    body = Request.BuildTransaction.add_actions(body, actions)

    API.build_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Builds a transaction of one or more transfer tokens actions.

  ## Parameters
    - `transfer_tokens_params_list`: List of transfer tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec build_transfer_tokens_transaction(
          list(transfer_tokens_params),
          fee_payer_address,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def build_transfer_tokens_transaction(
        transfer_tokens_params_list,
        fee_payer_address,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    message = Keyword.take(options, [:message])

    disable_token_mint_and_burn = Keyword.take(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(transfer_tokens_params_list, fn x ->
        []
        |> Request.BuildTransaction.Action.TransferTokens.type()
        |> Request.BuildTransaction.Action.TransferTokens.from_account(address: x.from_address)
        |> Request.BuildTransaction.Action.TransferTokens.to_account(address: x.to_address)
        |> Request.BuildTransaction.Action.TransferTokens.amount(amount: x.amount)
        |> Request.BuildTransaction.Action.TransferTokens.token_identifier(rri: x.token_rri)
        |> Util.stitch()
      end)

    body =
      []
      |> Request.BuildTransaction.network_identifier(network)
      |> Request.BuildTransaction.at_state_identifier(at_state_identifier)
      |> Request.BuildTransaction.fee_payer(address: fee_payer_address)
      |> Util.maybe_create_stitch_plan(message, &Request.BuildTransaction.message/2)
      |> Util.maybe_create_stitch_plan(
        disable_token_mint_and_burn,
        &Request.BuildTransaction.disable_token_mint_and_burn/2
      )
      |> Util.stitch()

    body = Request.BuildTransaction.add_actions(body, actions)

    API.build_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Builds a transaction of one or more stake tokens actions.

  ## Parameters
    - `stake_tokens_params_list`: List of stake tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec build_stake_tokens_transaction(
          list(stake_tokens_params),
          fee_payer_address,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def build_stake_tokens_transaction(
        stake_tokens_params_list,
        fee_payer_address,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    message = Keyword.take(options, [:message])

    disable_token_mint_and_burn = Keyword.take(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(stake_tokens_params_list, fn x ->
        []
        |> Request.BuildTransaction.Action.StakeTokens.type()
        |> Request.BuildTransaction.Action.StakeTokens.from_account(address: x.from_address)
        |> Request.BuildTransaction.Action.StakeTokens.to_validator(
          address: x.to_validator_address
        )
        |> Request.BuildTransaction.Action.StakeTokens.amount(amount: x.amount)
        |> Request.BuildTransaction.Action.StakeTokens.token_identifier(rri: x.token_rri)
        |> Util.stitch()
      end)

    body =
      []
      |> Request.BuildTransaction.network_identifier(network)
      |> Request.BuildTransaction.at_state_identifier(at_state_identifier)
      |> Request.BuildTransaction.fee_payer(address: fee_payer_address)
      |> Util.maybe_create_stitch_plan(message, &Request.BuildTransaction.message/2)
      |> Util.maybe_create_stitch_plan(
        disable_token_mint_and_burn,
        &Request.BuildTransaction.disable_token_mint_and_burn/2
      )
      |> Util.stitch()

    body = Request.BuildTransaction.add_actions(body, actions)

    API.build_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Builds a transaction of one or more unstake tokens actions.

  ## Parameters
    - `unstake_tokens_params_list`: List of unstake tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
      - `amount` (optional, string): Amount to unstake.
      - `unstake_percentage` (optional, integer): Percentage of currently staked XRD to unstake.
  """
  @spec build_unstake_tokens_transaction(
          list(unstake_tokens_params),
          fee_payer_address,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def build_unstake_tokens_transaction(
        unstake_tokens_params_list,
        fee_payer_address,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    message = Keyword.take(options, [:message])

    amount = Keyword.take(options, [:amount])
    unstake_percentage = Keyword.take(options, [:unstake_percentage])

    disable_token_mint_and_burn = Keyword.take(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(unstake_tokens_params_list, fn x ->
        []
        |> Request.BuildTransaction.Action.UnstakeTokens.type()
        |> Request.BuildTransaction.Action.UnstakeTokens.from_validator(
          address: x.from_validator_address
        )
        |> Request.BuildTransaction.Action.UnstakeTokens.to_account(address: x.to_address)
        |> Util.maybe_create_stitch_plan(
          amount,
          &Request.BuildTransaction.Action.UnstakeTokens.amount/2
        )
        |> Request.BuildTransaction.Action.UnstakeTokens.token_identifier(rri: x.token_rri)
        |> Util.maybe_create_stitch_plan(
          unstake_percentage,
          &Request.BuildTransaction.Action.UnstakeTokens.unstake_percentage/2
        )
        |> Util.stitch()
      end)

    body =
      []
      |> Request.BuildTransaction.network_identifier(network)
      |> Request.BuildTransaction.at_state_identifier(at_state_identifier)
      |> Request.BuildTransaction.fee_payer(address: fee_payer_address)
      |> Util.maybe_create_stitch_plan(message, &Request.BuildTransaction.message/2)
      |> Util.maybe_create_stitch_plan(
        disable_token_mint_and_burn,
        &Request.BuildTransaction.disable_token_mint_and_burn/2
      )
      |> Util.stitch()

    body = Request.BuildTransaction.add_actions(body, actions)

    API.build_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Builds a transaction of one or more mint tokens actions.

  ## Parameters
    - `mint_tokens_params_list`: List of mint tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec build_mint_tokens_transaction(
          list(mint_tokens_params),
          fee_payer_address,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def build_mint_tokens_transaction(
        mint_tokens_params_list,
        fee_payer_address,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    message = Keyword.take(options, [:message])

    disable_token_mint_and_burn = Keyword.take(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(mint_tokens_params_list, fn x ->
        []
        |> Request.BuildTransaction.Action.MintTokens.type()
        |> Request.BuildTransaction.Action.MintTokens.to_account(address: x.to_address)
        |> Request.BuildTransaction.Action.MintTokens.amount(amount: x.amount)
        |> Request.BuildTransaction.Action.MintTokens.token_identifier(rri: x.token_rri)
        |> Util.stitch()
      end)

    body =
      []
      |> Request.BuildTransaction.network_identifier(network)
      |> Request.BuildTransaction.at_state_identifier(at_state_identifier)
      |> Request.BuildTransaction.fee_payer(address: fee_payer_address)
      |> Util.maybe_create_stitch_plan(message, &Request.BuildTransaction.message/2)
      |> Util.maybe_create_stitch_plan(
        disable_token_mint_and_burn,
        &Request.BuildTransaction.disable_token_mint_and_burn/2
      )
      |> Util.stitch()

    body = Request.BuildTransaction.add_actions(body, actions)

    API.build_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Builds a transaction of one or more burn tokens actions.

  ## Parameters
    - `burn_tokens_params_list`: List of burn tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec build_burn_tokens_transaction(
          list(burn_tokens_params),
          fee_payer_address,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def build_burn_tokens_transaction(
        burn_tokens_params_list,
        fee_payer_address,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    message = Keyword.take(options, [:message])

    disable_token_mint_and_burn = Keyword.take(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(burn_tokens_params_list, fn x ->
        []
        |> Request.BuildTransaction.Action.BurnTokens.type()
        |> Request.BuildTransaction.Action.BurnTokens.from_account(address: x.from_address)
        |> Request.BuildTransaction.Action.BurnTokens.amount(amount: x.amount)
        |> Request.BuildTransaction.Action.BurnTokens.token_identifier(rri: x.token_rri)
        |> Util.stitch()
      end)

    body =
      []
      |> Request.BuildTransaction.network_identifier(network)
      |> Request.BuildTransaction.at_state_identifier(at_state_identifier)
      |> Request.BuildTransaction.fee_payer(address: fee_payer_address)
      |> Util.maybe_create_stitch_plan(message, &Request.BuildTransaction.message/2)
      |> Util.maybe_create_stitch_plan(
        disable_token_mint_and_burn,
        &Request.BuildTransaction.disable_token_mint_and_burn/2
      )
      |> Util.stitch()

    body = Request.BuildTransaction.add_actions(body, actions)

    API.build_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Builds a transaction of one or more register validator actions.

  ## Parameters
    - `validator_addresses_list`: List of validator addresses
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec build_register_validator_transaction(
          list(validator_address),
          fee_payer_address,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def build_register_validator_transaction(
        validator_addresses_list,
        fee_payer_address,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    message = Keyword.take(options, [:message])

    disable_token_mint_and_burn = Keyword.take(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(validator_addresses_list, fn x ->
        []
        |> Request.BuildTransaction.Action.RegisterValidator.type()
        |> Request.BuildTransaction.Action.RegisterValidator.validator(
          validator_address: x.validator_address
        )
        |> Util.stitch()
      end)

    body =
      []
      |> Request.BuildTransaction.network_identifier(network)
      |> Request.BuildTransaction.at_state_identifier(at_state_identifier)
      |> Request.BuildTransaction.fee_payer(address: fee_payer_address)
      |> Util.maybe_create_stitch_plan(message, &Request.BuildTransaction.message/2)
      |> Util.maybe_create_stitch_plan(
        disable_token_mint_and_burn,
        &Request.BuildTransaction.disable_token_mint_and_burn/2
      )
      |> Util.stitch()

    body = Request.BuildTransaction.add_actions(body, actions)

    API.build_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Builds a transaction of one or more unregister validator actions.

  ## Parameters
    - `validator_addresses_list`: List of validator addresses
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec build_unregister_validator_transaction(
          list(validator_address),
          fee_payer_address,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def build_unregister_validator_transaction(
        validator_addresses_list,
        fee_payer_address,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    message = Keyword.take(options, [:message])

    disable_token_mint_and_burn = Keyword.take(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(validator_addresses_list, fn x ->
        []
        |> Request.BuildTransaction.Action.UnregisterValidator.type()
        |> Request.BuildTransaction.Action.UnregisterValidator.validator(
          validator_address: x.validator_address
        )
        |> Util.stitch()
      end)

    body =
      []
      |> Request.BuildTransaction.network_identifier(network)
      |> Request.BuildTransaction.at_state_identifier(at_state_identifier)
      |> Request.BuildTransaction.fee_payer(address: fee_payer_address)
      |> Util.maybe_create_stitch_plan(message, &Request.BuildTransaction.message/2)
      |> Util.maybe_create_stitch_plan(
        disable_token_mint_and_burn,
        &Request.BuildTransaction.disable_token_mint_and_burn/2
      )
      |> Util.stitch()

    body = Request.BuildTransaction.add_actions(body, actions)

    API.build_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets a signed transaction payload and transaction identifier, from an unsigned transaction payload and signature.

  ## Parameters
    - `unsigned_transaction`: Unsigned transaction
    - `signature_public_key`: Public key that will sign transaction
    - `signature_bytes`: Bytes of signature
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `submit` (optional, boolean): If true, the transaction is immediately submitted after finalization.
  """
  @spec finalize_transaction(unsigned_transaction, signature_public_key, signature_bytes, options) ::
          {:ok, map} | {:error, map | error_message}
  def finalize_transaction(
        unsigned_transaction,
        signature_public_key,
        signature_bytes,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])

    submit = Keyword.take(options, [:submit])

    body =
      []
      |> Request.FinalizeTransaction.network_identifier(network)
      |> Request.FinalizeTransaction.unsigned_transaction(
        unsigned_transaction: unsigned_transaction
      )
      |> Request.FinalizeTransaction.signature(
        hex: signature_public_key,
        bytes: signature_bytes
      )
      |> Util.maybe_create_stitch_plan(submit, &Request.FinalizeTransaction.submit/2)
      |> Util.stitch()

    API.finalize_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Submits a signed transaction payload to the network.

  ## Parameters
    - `signed_transaction`: Signed transaction
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec submit_transaction(signed_transaction, options) ::
          {:ok, map} | {:error, map | error_message}
  def submit_transaction(signed_transaction, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.SubmitTransaction.network_identifier(network)
      |> Request.SubmitTransaction.signed_transaction(signed_transaction: signed_transaction)
      |> Util.stitch()

    API.submit_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets the status and contents of the transaction with the given transaction identifier.

  ## Parameters
    - `transaction_hash`: Transaction hash
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_transaction_status(transaction_hash, options) ::
          {:ok, map} | {:error, map | error_message}
  def get_transaction_status(transaction_hash, options \\ []) do
    network = Keyword.take(options, [:network])

    at_state_identifier = Keyword.take(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetTransactionStatus.network_identifier(network)
      |> Request.GetTransactionStatus.transaction_identifier(hash: transaction_hash)
      |> Request.GetTransactionStatus.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_transaction_status(body, Keyword.get(options, :api, []))
  end

  @doc """
  Creates tokens.

  ## Parameters
    - `create_token_params_list`: List of create token params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec create_token(
          list(create_token_params),
          fee_payer_address,
          private_key,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def create_token(
        create_token_params_list,
        fee_payer_address,
        private_key,
        options \\ []
      ) do
    transaction_pipeline(
      create_token_params_list,
      fee_payer_address,
      private_key,
      options,
      &build_create_token_transaction/3
    )
  end

  @doc """
  Transfers tokens.

  ## Parameters
    - `transfer_tokens_params_list`: List of transfer tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec transfer_tokens(
          list(transfer_tokens_params),
          fee_payer_address,
          private_key,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def transfer_tokens(
        transfer_tokens_params_list,
        fee_payer_address,
        private_key,
        options \\ []
      ) do
    transaction_pipeline(
      transfer_tokens_params_list,
      fee_payer_address,
      private_key,
      options,
      &build_transfer_tokens_transaction/3
    )
  end

  @doc """
  Stakes tokens.

  ## Parameters
    - `stake_tokens_params_list`: List of stake tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec stake_tokens(
          list(stake_tokens_params),
          fee_payer_address,
          private_key,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def stake_tokens(
        stake_tokens_params_list,
        fee_payer_address,
        private_key,
        options \\ []
      ) do
    transaction_pipeline(
      stake_tokens_params_list,
      fee_payer_address,
      private_key,
      options,
      &build_stake_tokens_transaction/3
    )
  end

  @doc """
  Unstakes tokens.

  ## Parameters
    - `unstake_tokens_params_list`: List of unstake tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
      - `amount` (optional, string): Amount to unstake.
      - `unstake_percentage` (optional, integer): Percentage of currently staked XRD to unstake.
  """
  @spec unstake_tokens(
          list(unstake_tokens_params),
          fee_payer_address,
          private_key,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def unstake_tokens(
        unstake_tokens_params_list,
        fee_payer_address,
        private_key,
        options \\ []
      ) do
    transaction_pipeline(
      unstake_tokens_params_list,
      fee_payer_address,
      private_key,
      options,
      &build_unstake_tokens_transaction/3
    )
  end

  @doc """
  Mint tokens.

  ## Parameters
    - `mint_tokens_params_list`: List of mint tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec mint_tokens(
          list(mint_tokens_params),
          fee_payer_address,
          private_key,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def mint_tokens(
        mint_tokens_params_list,
        fee_payer_address,
        private_key,
        options \\ []
      ) do
    transaction_pipeline(
      mint_tokens_params_list,
      fee_payer_address,
      private_key,
      options,
      &build_mint_tokens_transaction/3
    )
  end

  @doc """
  Burn tokens.

  ## Parameters
    - `burn_tokens_params_list`: List of burn tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec burn_tokens(
          list(burn_tokens_params),
          fee_payer_address,
          private_key,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def burn_tokens(
        burn_tokens_params_list,
        fee_payer_address,
        private_key,
        options \\ []
      ) do
    transaction_pipeline(
      burn_tokens_params_list,
      fee_payer_address,
      private_key,
      options,
      &build_burn_tokens_transaction/3
    )
  end

  @doc """
  Register validators.

  ## Parameters
    - `validator_addresses_list`: List of validator addresses
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec register_validator(
          list(validator_address),
          fee_payer_address,
          private_key,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def register_validator(
        validator_addresses_list,
        fee_payer_address,
        private_key,
        options \\ []
      ) do
    transaction_pipeline(
      validator_addresses_list,
      fee_payer_address,
      private_key,
      options,
      &build_register_validator_transaction/3
    )
  end

  @doc """
  Unregister validators.

  ## Parameters
    - `validator_addresses_list`: List of validator addresses
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec unregister_validator(
          list(validator_address),
          fee_payer_address,
          private_key,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def unregister_validator(
        validator_addresses_list,
        fee_payer_address,
        private_key,
        options \\ []
      ) do
    transaction_pipeline(
      validator_addresses_list,
      fee_payer_address,
      private_key,
      options,
      &build_unregister_validator_transaction/3
    )
  end

  defp transaction_pipeline(
         action_params_list,
         fee_payer_address,
         private_key,
         options,
         build_transaction
       ) do
    with {:ok, %{public_key: public_key}} <- Key.from_private_key(private_key),
         {:ok, built_transaction} <-
           build_transaction.(
             action_params_list,
             fee_payer_address,
             options
           ),
         :ok <-
           Util.verify_hash(
             built_transaction["transaction_build"]["unsigned_transaction"],
             built_transaction["transaction_build"]["payload_to_sign"]
           ),
         {:ok, signature_bytes} <-
           Key.sign_data(built_transaction["transaction_build"]["payload_to_sign"], private_key),
         {:ok, finalized_transaction} <-
           finalize_transaction(
             built_transaction["transaction_build"]["unsigned_transaction"],
             public_key,
             signature_bytes,
             options
           ) do
      case submit_transaction(finalized_transaction["signed_transaction"], options) do
        {:ok, submitted_transaction} ->
          {:ok,
           %{
             built_transaction: built_transaction,
             finalized_transaction: finalized_transaction,
             submitted_transaction: submitted_transaction
           }}

        {:error, error} ->
          {:error,
           %{
             built_transaction: built_transaction,
             finalized_transaction: finalized_transaction,
             submitted_transaction_error: error
           }}
      end
    end
  end
end
