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
      |> Request.GetAccountTransactions.cursor(cursor)
      |> Request.GetAccountTransactions.limit(limit)
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
      |> Request.GetValidatorStakes.cursor(cursor)
      |> Request.GetValidatorStakes.limit(limit)
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

  # TODO: build transaction goes here

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
      |> Request.FinalizeTransaction.submit(submit: submit)
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
