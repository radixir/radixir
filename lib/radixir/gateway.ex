defmodule Radixir.Gateway do
  alias Radixir.Gateway.API
  alias Radixir.Gateway.Request
  alias Radixir.Util

  @type public_key :: String.t()
  @type address :: String.t()
  @type rri :: String.t()
  @type symbol :: String.t()
  @type options :: keyword()
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
          amount: String.t(),
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
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
  """
  def get_info(options \\ []) do
    API.get_info(options)
  end

  @doc """
  Gets the account address associated with the given public key.

  ## Parameters
    - `public_key`: Public key
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec derive_account_identifier(public_key, options) ::
          {:ok, map()} | {:error, map | error_message}
  def derive_account_identifier(public_key, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    body =
      []
      |> Request.DeriveAccountIdentifier.network_identifier(network)
      |> Request.DeriveAccountIdentifier.public_key(hex: public_key)
      |> Util.stitch()

    API.derive_account_identifier(body, options)
  end

  @doc """
  Gets an account's available and staked token balances.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_account_balances(address, options) ::
          {:ok, map()} | {:error, map | error_message}
  def get_account_balances(address, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetAccountBalances.network_identifier(network)
      |> Request.GetAccountBalances.account_identifier(address: address)
      |> Request.GetAccountBalances.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_account_balances(body, options)
  end

  @doc """
  Gets the xrd which the account has in pending and active delegated stake positions with validators.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_stake_positions(address, options) ::
          {:ok, map()} | {:error, map | error_message}
  def get_stake_positions(address, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetStakePositions.network_identifier(network)
      |> Request.GetStakePositions.account_identifier(address: address)
      |> Request.GetStakePositions.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_stake_positions(body, options)
  end

  @doc """
  Gets the xrd which the account has in pending and temporarily-locked delegated unstake positions with validators.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_unstake_positions(address, options) ::
          {:ok, map()} | {:error, map | error_message}
  def get_unstake_positions(address, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetUnstakePositions.network_identifier(network)
      |> Request.GetUnstakePositions.account_identifier(address: address)
      |> Request.GetUnstakePositions.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_unstake_positions(body, options)
  end

  @doc """
  Gets user-initiated transactions involving the given account address which have been succesfully committed to the ledger.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_account_transactions(address, options) ::
          {:ok, map()} | {:error, map | error_message}
  def get_account_transactions(address, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    {cursor, options} = Util.take_and_drop(options, [:cursor])

    {limit, options} = Util.take_and_drop(options, [:limit])

    body =
      []
      |> Request.GetAccountTransactions.network_identifier(network)
      |> Request.GetAccountTransactions.account_identifier(address: address)
      |> Request.GetAccountTransactions.at_state_identifier(at_state_identifier)
      |> Util.maybe_create_stitch_plan(cursor, &Request.GetAccountTransactions.cursor/2)
      |> Util.maybe_create_stitch_plan(limit, &Request.GetAccountTransactions.limit/2)
      |> Util.stitch()

    API.get_account_transactions(body, options)
  end

  @doc """
  Gets information about xrd, including its Radix Resource Identifier.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_native_token_info(options) ::
          {:ok, map()} | {:error, map | error_message}
  def get_native_token_info(options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetNativeTokenInfo.network_identifier(network)
      |> Request.GetNativeTokenInfo.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_native_token_info(body, options)
  end

  @doc """
  Gets information about any token, given its Radix Resource Identifier.

  ## Parameters
    - `rri`: Radix Resource Identifier
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_token_info(rri, options) ::
          {:ok, map()} | {:error, map | error_message}
  def get_token_info(rri, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetTokenInfo.network_identifier(network)
      |> Request.GetTokenInfo.token_identifier(rri: rri)
      |> Request.GetTokenInfo.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_token_info(body, options)
  end

  @doc """
  Gets the Radix Resource Identifier of a token with the given symbol, created by an account with the given public key.

  ## Parameters
    - `public_key`: Public key
    - `symbol`: Token symbol
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec derive_token_identifier(public_key, symbol, options) ::
          {:ok, map()} | {:error, map | error_message}
  def derive_token_identifier(public_key, symbol, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    body =
      []
      |> Request.DeriveTokenIdentifier.network_identifier(network)
      |> Request.DeriveTokenIdentifier.public_key(hex: public_key)
      |> Request.DeriveTokenIdentifier.symbol(symbol: symbol)
      |> Util.stitch()

    API.derive_token_identifier(body, options)
  end

  @doc """
  Gets information about a validator, given a validator address.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_validator(address, options) ::
          {:ok, map()} | {:error, map | error_message}
  def get_validator(address, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetValidator.network_identifier(network)
      |> Request.GetValidator.validator_identifier(address: address)
      |> Request.GetValidator.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_validator(body, options)
  end

  @doc """
  Gets the validator address associated with the given public key.

  ## Parameters
    - `public_key`: Public key
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec derive_validator_identifier(public_key, options) ::
          {:ok, map()} | {:error, map | error_message}
  def derive_validator_identifier(public_key, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    body =
      []
      |> Request.DeriveValidatorIdentifier.network_identifier(network)
      |> Request.DeriveValidatorIdentifier.public_key(hex: public_key)
      |> Util.stitch()

    API.derive_validator_identifier(body, options)
  end

  @doc """
  Gets information about all validators.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_validators(options) ::
          {:ok, map()} | {:error, map | error_message}
  def get_validators(options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetValidators.network_identifier(network)
      |> Request.GetValidators.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_validators(body, options)
  end

  @doc """
  Gets paginated results about the delegated stakes from accounts to a validator.

  ## Parameters
    - `address`: Radix address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_validator_stakes(address, options) ::
          {:ok, map()} | {:error, map | error_message}
  def get_validator_stakes(address, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    {cursor, options} = Util.take_and_drop(options, [:cursor])

    {limit, options} = Util.take_and_drop(options, [:limit])

    body =
      []
      |> Request.GetValidatorStakes.network_identifier(network)
      |> Request.GetValidatorStakes.validator_identifier(address: address)
      |> Request.GetValidatorStakes.at_state_identifier(at_state_identifier)
      |> Util.maybe_create_stitch_plan(cursor, &Request.GetValidatorStakes.cursor/2)
      |> Util.maybe_create_stitch_plan(limit, &Request.GetValidatorStakes.limit/2)
      |> Util.stitch()

    API.get_validator_stakes(body, options)
  end

  @doc """
  Gets the current rules used to build and validate transactions in the Radix Engine.

  ## Parameters
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_transaction_rules(options) ::
          {:ok, map()} | {:error, map | error_message}
  def get_transaction_rules(options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetValidatorStakes.network_identifier(network)
      |> Request.GetValidatorStakes.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_transaction_rules(body, options)
  end

  @doc """
  Builds a transaction of one or more create token actions.

  ## Parameters
    - `create_token_params_list`: List of create token params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
  """
  @spec build_create_token_transaction(list(create_token_params), fee_payer_address, options) ::
          {:ok, map()} | {:error, map | error_message}
  def build_create_token_transaction(create_token_params_list, fee_payer_address, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    {message, options} = Util.take_and_drop(options, [:message])

    {disable_token_mint_and_burn, options} =
      Util.take_and_drop(options, [:disable_token_mint_and_burn])

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

    API.build_transaction(body, options)
    # create_token_params = %{
    #   name: "JEC Token",
    #   description: "jec tokens ftw",
    #   icon_url: "https://me.me/icon",
    #   url: "https://me.me",
    #   symbol: "jec",
    #   is_supply_mutable: true,
    #   granularity: "1",
    #   owner_address: "tdx1qspf8f3eeg06955d5pzgvntz36c6nych7f8jw68mdmhlzvflj7pylqs9qzh0z",
    #   token_supply: "0",
    #   token_rri: "jec_tr1qvnc03t4m6te6zlkcy03q4sst5ddcad49urt6ggr7lvq6he0sq",
    #   to_account_address: "tdx1qspf8f3eeg06955d5pzgvntz36c6nych7f8jw68mdmhlzvflj7pylqs9qzh0z"
    # }
  end

  @doc """
  Builds a transaction of one or more transfer tokens actions.

  ## Parameters
    - `transfer_tokens_params_list`: List of transfer tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
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
          {:ok, map()} | {:error, map | error_message}
  def build_transfer_tokens_transaction(
        transfer_tokens_params_list,
        fee_payer_address,
        options \\ []
      ) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    {message, options} = Util.take_and_drop(options, [:message])

    {disable_token_mint_and_burn, options} =
      Util.take_and_drop(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(transfer_tokens_params_list, fn x ->
        []
        |> Request.BuildTransaction.Action.TransferTokens.type()
        |> Request.BuildTransaction.Action.TransferTokens.from_account(address: x.from_address)
        |> Request.BuildTransaction.Action.TransferTokens.to_account(address: x.to_address)
        |> Request.BuildTransaction.Action.TransferTokens.amount(value: x.amount)
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

    API.build_transaction(body, options)

    # transfer_tokens_params = %{
    #   from_address: "tdx1qspf8f3eeg06955d5pzgvntz36c6nych7f8jw68mdmhlzvflj7pylqs9qzh0z",
    #   to_address: "tdx1qspa8jmwnd8se6u3qmpdljryets2mv3e5u8eh2cnwmz6jquh5c2zs8src9qxu",
    #   amount: "10000000000000000",
    #   token_rri: "xrd_tr1qyf0x76s"
    # }
  end

  @doc """
  Builds a transaction of one or more stake tokens actions.

  ## Parameters
    - `stake_tokens_params_list`: List of stake tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
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
          {:ok, map()} | {:error, map | error_message}
  def build_stake_tokens_transaction(
        stake_tokens_params_list,
        fee_payer_address,
        options \\ []
      ) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    {message, options} = Util.take_and_drop(options, [:message])

    {disable_token_mint_and_burn, options} =
      Util.take_and_drop(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(stake_tokens_params_list, fn x ->
        []
        |> Request.BuildTransaction.Action.StakeTokens.type()
        |> Request.BuildTransaction.Action.StakeTokens.from_account(address: x.from_address)
        |> Request.BuildTransaction.Action.StakeTokens.to_validator(
          address: x.to_validator_address
        )
        |> Request.BuildTransaction.Action.StakeTokens.amount(value: x.amount)
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

    API.build_transaction(body, options)
  end

  @doc """
  Builds a transaction of one or more unstake tokens actions.

  ## Parameters
    - `unstake_tokens_params_list`: List of unstake tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_token_mint_and_burn` (optional, boolean): Disable Token Mint and Burn.
      - `unstake_percentage` (optional, integer): Percentage of currently staked XRD to unstake.
  """
  @spec build_unstake_tokens_transaction(
          list(unstake_tokens_params),
          fee_payer_address,
          options
        ) ::
          {:ok, map()} | {:error, map | error_message}
  def build_unstake_tokens_transaction(
        unstake_tokens_params_list,
        fee_payer_address,
        options \\ []
      ) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    {message, options} = Util.take_and_drop(options, [:message])

    {unstake_percentage, options} = Util.take_and_drop(options, [:unstake_percentage])

    {disable_token_mint_and_burn, options} =
      Util.take_and_drop(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(unstake_tokens_params_list, fn x ->
        []
        |> Request.BuildTransaction.Action.UnstakeTokens.type()
        |> Request.BuildTransaction.Action.UnstakeTokens.from_validator(
          address: x.from_validator_address
        )
        |> Request.BuildTransaction.Action.UnstakeTokens.to_account(address: x.to_address)
        |> Request.BuildTransaction.Action.UnstakeTokens.amount(value: x.amount)
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

    API.build_transaction(body, options)
  end

  @doc """
  Builds a transaction of one or more mint tokens actions.

  ## Parameters
    - `mint_tokens_params_list`: List of mint tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
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
          {:ok, map()} | {:error, map | error_message}
  def build_mint_tokens_transaction(
        mint_tokens_params_list,
        fee_payer_address,
        options \\ []
      ) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    {message, options} = Util.take_and_drop(options, [:message])

    {disable_token_mint_and_burn, options} =
      Util.take_and_drop(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(mint_tokens_params_list, fn x ->
        []
        |> Request.BuildTransaction.Action.MintTokens.type()
        |> Request.BuildTransaction.Action.MintTokens.to_account(address: x.to_address)
        |> Request.BuildTransaction.Action.MintTokens.amount(value: x.amount)
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

    API.build_transaction(body, options)
  end

  @doc """
  Builds a transaction of one or more burn tokens actions.

  ## Parameters
    - `burn_tokens_params_list`: List of burn tokens params
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
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
          {:ok, map()} | {:error, map | error_message}
  def build_burn_tokens_transaction(
        burn_tokens_params_list,
        fee_payer_address,
        options \\ []
      ) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    {message, options} = Util.take_and_drop(options, [:message])

    {disable_token_mint_and_burn, options} =
      Util.take_and_drop(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(burn_tokens_params_list, fn x ->
        []
        |> Request.BuildTransaction.Action.BurnTokens.type()
        |> Request.BuildTransaction.Action.BurnTokens.from_account(address: x.from_address)
        |> Request.BuildTransaction.Action.BurnTokens.amount(value: x.amount)
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

    API.build_transaction(body, options)
  end

  @doc """
  Builds a transaction of one or more register validator actions.

  ## Parameters
    - `validator_addresses_list`: List of validator addresses
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
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
          {:ok, map()} | {:error, map | error_message}
  def build_register_validator_transaction(
        validator_addresses_list,
        fee_payer_address,
        options \\ []
      ) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    {message, options} = Util.take_and_drop(options, [:message])

    {disable_token_mint_and_burn, options} =
      Util.take_and_drop(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(validator_addresses_list, fn x ->
        []
        |> Request.BuildTransaction.Action.RegisterValidator.type()
        |> Request.BuildTransaction.Action.RegisterValidator.validator(
          address: x.validator_address
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

    API.build_transaction(body, options)
  end

  @doc """
  Builds a transaction of one or more unregister validator actions.

  ## Parameters
    - `validator_addresses_list`: List of validator addresses
    - `fee_payer_address`: Fee payer address
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
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
          {:ok, map()} | {:error, map | error_message}
  def build_unregister_validator_transaction(
        validator_addresses_list,
        fee_payer_address,
        options \\ []
      ) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    {message, options} = Util.take_and_drop(options, [:message])

    {disable_token_mint_and_burn, options} =
      Util.take_and_drop(options, [:disable_token_mint_and_burn])

    actions =
      Enum.map(validator_addresses_list, fn x ->
        []
        |> Request.BuildTransaction.Action.UnregisterValidator.type()
        |> Request.BuildTransaction.Action.UnregisterValidator.validator(
          address: x.validator_address
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

    API.build_transaction(body, options)
  end

  @doc """
  Gets a signed transaction payload and transaction identifier, from an unsigned transaction payload and signature.

  ## Parameters
    - `unsigned_transaction`: Unsigned transaction
    - `signature_public_key`: Public key that will sign transaction
    - `signature_bytes`: Bytes of signature
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `submit` (optional, boolean): If true, the transaction is immediately submitted after finalization.
  """
  @spec finalize_transaction(unsigned_transaction, signature_public_key, signature_bytes, options) ::
          {:ok, map()} | {:error, map | error_message}
  def finalize_transaction(
        unsigned_transaction,
        signature_public_key,
        signature_bytes,
        options \\ []
      ) do
    {network, options} = Util.take_and_drop(options, [:network])

    {submit, options} = Util.take_and_drop(options, [:submit])

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

    API.finalize_transaction(body, options)
  end

  @doc """
  Submits a signed transaction payload to the network.

  ## Parameters
    - `signed_transaction`: Signed transaction
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec submit_transaction(signed_transaction, options) ::
          {:ok, map()} | {:error, map | error_message}
  def submit_transaction(signed_transaction, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    body =
      []
      |> Request.SubmitTransaction.network_identifier(network)
      |> Request.SubmitTransaction.signed_transaction(signed_transaction: signed_transaction)
      |> Util.stitch()

    API.submit_transaction(body, options)
  end

  @doc """
  Gets the status and contents of the transaction with the given transaction identifier.

  ## Parameters
    - `transaction_hash`: Transaction hash
    - `options`: Keyword list that contains
      - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `version` (optional, integer): Version key in `at_state_identifier` map.
      - `timestamp` (optional, string): Timestamp key in `at_state_identifier` map.
      - `epoch` (optional, integer): Epoch key in `at_state_identifier` map.
      - `round` (optional, integer): Round key in `at_state_identifier` map.
  """
  @spec get_transaction_status(transaction_hash, options) ::
          {:ok, map()} | {:error, map | error_message}
  def get_transaction_status(transaction_hash, options \\ []) do
    {network, options} = Util.take_and_drop(options, [:network])

    {at_state_identifier, options} =
      Util.take_and_drop(options, [:version, :timestamp, :epoch, :round])

    body =
      []
      |> Request.GetTransactionStatus.network_identifier(network)
      |> Request.GetTransactionStatus.transaction_identifier(hash: transaction_hash)
      |> Request.GetTransactionStatus.at_state_identifier(at_state_identifier)
      |> Util.stitch()

    API.get_transaction_status(body, options)
  end
end
