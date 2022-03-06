defmodule Radixir.Core do
  @moduledoc """
  Provides high level interaction with the Core API.
  """

  alias Radixir.Core.API
  alias Radixir.Core.Request
  alias Radixir.Key
  alias Radixir.Util

  @type public_key :: String.t()
  @type private_key :: String.t()
  @type type :: String.t()
  @type address :: String.t()
  @type amount :: String.t()
  @type rri :: String.t()
  @type symbol :: String.t()
  @type round :: integer
  @type epoch :: integer
  @type timestamp :: integer
  @type state_version :: integer
  @type action :: String.t()
  @type substate_data_hex :: String.t()
  @type options :: keyword
  @type error_message :: String.t()
  @type epoch_unlock :: integer
  @type unsigned_transaction :: String.t()
  @type transaction :: String.t()
  @type signed :: boolean
  @type signed_transaction :: String.t()
  @type signature_bytes :: String.t()
  @type signature_public_key :: String.t()
  @type transaction_hash :: String.t()
  @type fee_payer_address :: String.t()
  @type validator_address :: String.t()
  @type operation_groups :: list
  @type substate_operation :: String.t()
  @type substate_identifier :: String.t()

  @doc """
  Gets network configuration.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_network_configuration(options) :: {:ok, map} | {:error, map | error_message}
  def get_network_configuration(options \\ []) do
    API.get_network_configuration(Keyword.get(options, :api, []))
  end

  @doc """
  Gets network status.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_network_status(options) :: {:ok, map} | {:error, map | error_message}
  def get_network_status(options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.GetNetworkStatus.network_identifier(network)
      |> Util.stitch()

    API.get_network_status(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets entity information.

  ## Parameters
    - `address`: Radix address.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_entity_information(address, options) :: {:ok, map} | {:error, map | error_message}
  def get_entity_information(address, options \\ []) do
    network = Keyword.take(options, [:network])
    sub_entity = Keyword.take(options, [:sub_entity_address, :validator_address, :epoch_unlock])

    body =
      []
      |> Request.GetEntityInformation.network_identifier(network)
      |> Request.GetEntityInformation.entity_identifier(address: address)
      |> Util.maybe_create_stitch_plan(sub_entity, &Request.GetEntityInformation.sub_entity/2)
      |> Util.stitch()

    API.get_entity_information(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets mempool transactions.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_mempool_transactions(options) :: {:ok, map} | {:error, map | error_message}
  def get_mempool_transactions(options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.GetMempoolTransactions.network_identifier(network)
      |> Util.stitch()

    API.get_mempool_transactions(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets mempool transaction.

  ## Parameters
    - `transaction_hash`: Transaction hash.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_mempool_transaction(transaction_hash, options) ::
          {:ok, map} | {:error, map | error_message}
  def get_mempool_transaction(transaction_hash, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.GetMempoolTransaction.network_identifier(network)
      |> Request.GetMempoolTransaction.transaction_identifier(hash: transaction_hash)
      |> Util.stitch()

    API.get_mempool_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets committed transactions.

  ## Parameters
    - `state_version`: State version.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `transaction_accumulator` (optional, string): Transaction accumulator in state identifier map.
      - `limit` (optional, integer): Maximum number of transactions that will be returned.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_committed_transactions(state_version, options) ::
          {:ok, map} | {:error, map | error_message}
  def get_committed_transactions(state_version, options \\ []) do
    network = Keyword.take(options, [:network])
    limit = Keyword.take(options, [:limit])
    state_version = [state_version: state_version]
    transaction_accumulator = Keyword.take(options, [:transaction_accumulator])
    state_version = Keyword.merge(state_version, transaction_accumulator)

    body =
      []
      |> Request.GetCommittedTransactions.network_identifier(network)
      |> Request.GetCommittedTransactions.state_identifier(state_version)
      |> Util.maybe_create_stitch_plan(limit, &Request.GetCommittedTransactions.limit/2)
      |> Util.stitch()

    API.get_committed_transactions(body, Keyword.get(options, :api, []))
  end

  @doc """
  Derives `Account` entity identifier.

  ## Parameters
    - `public_key`: Public key.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec derive_account_entity_identifier(public_key, options) ::
          {:ok, map} | {:error, map | error_message}
  def derive_account_entity_identifier(public_key, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.DeriveEntityIdentifier.network_identifier(network)
      |> Request.DeriveEntityIdentifier.public_key(hex: public_key)
      |> Request.DeriveEntityIdentifier.Metadata.Account.type()
      |> Util.stitch()

    API.derive_entity_identifier(body, Keyword.get(options, :api, []))
  end

  @doc """
  Derives `Validator` entity identifier.

  ## Parameters
    - `public_key`: Public key.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec derive_validator_entity_identifier(public_key, options) ::
          {:ok, map} | {:error, map | error_message}
  def derive_validator_entity_identifier(public_key, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.DeriveEntityIdentifier.network_identifier(network)
      |> Request.DeriveEntityIdentifier.public_key(hex: public_key)
      |> Request.DeriveEntityIdentifier.Metadata.Validator.type()
      |> Util.stitch()

    API.derive_entity_identifier(body, Keyword.get(options, :api, []))
  end

  @doc """
  Derives `Token` entity identifier.

  ## Parameters
    - `public_key`: Public key.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec derive_token_entity_identifier(public_key, symbol, options) ::
          {:ok, map} | {:error, map | error_message}
  def derive_token_entity_identifier(public_key, symbol, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.DeriveEntityIdentifier.network_identifier(network)
      |> Request.DeriveEntityIdentifier.public_key(hex: public_key)
      |> Request.DeriveEntityIdentifier.Metadata.Token.type()
      |> Request.DeriveEntityIdentifier.Metadata.Token.symbol(symbol: symbol)
      |> Util.stitch()

    API.derive_entity_identifier(body, Keyword.get(options, :api, []))
  end

  @doc """
  Derives `PreparedStakes` entity identifier.

  ## Parameters
    - `public_key`: Public key.
    - `validator_address`: Radix address.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec derive_prepared_stakes_entity_identifier(public_key, validator_address, options) ::
          {:ok, map} | {:error, map | error_message}
  def derive_prepared_stakes_entity_identifier(public_key, validator_address, options \\ []) do
    network = Keyword.take(options, [:network])
    sub_entity = Keyword.take(options, [:sub_entity_address, :validator_address, :epoch_unlock])

    body =
      []
      |> Request.DeriveEntityIdentifier.network_identifier(network)
      |> Request.DeriveEntityIdentifier.public_key(hex: public_key)
      |> Request.DeriveEntityIdentifier.Metadata.PreparedStakes.type()
      |> Request.DeriveEntityIdentifier.Metadata.PreparedStakes.validator(
        address: validator_address
      )
      |> Util.maybe_create_stitch_plan(
        sub_entity,
        &Request.DeriveEntityIdentifier.Metadata.PreparedStakes.sub_entity/2
      )
      |> Util.stitch()

    API.derive_entity_identifier(body, Keyword.get(options, :api, []))
  end

  @doc """
  Derives `PreparedUnstakes` entity identifier.

  ## Parameters
    - `public_key`: Public key.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec derive_prepared_unstakes_entity_identifier(public_key, options) ::
          {:ok, map} | {:error, map | error_message}
  def derive_prepared_unstakes_entity_identifier(public_key, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.DeriveEntityIdentifier.network_identifier(network)
      |> Request.DeriveEntityIdentifier.public_key(hex: public_key)
      |> Request.DeriveEntityIdentifier.Metadata.PreparedUnstakes.type()
      |> Util.stitch()

    API.derive_entity_identifier(body, Keyword.get(options, :api, []))
  end

  @doc """
  Derives `ExitingUnstakes` entity identifier.

  ## Parameters
    - `public_key`: Public key.
    - `validator_address`: Radix address.
    - `epoch_unlock`: Epoch unlock.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec derive_exiting_unstakes_entity_identifier(
          public_key,
          validator_address,
          epoch_unlock,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def derive_exiting_unstakes_entity_identifier(
        public_key,
        validator_address,
        epoch_unlock,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])
    sub_entity = Keyword.take(options, [:sub_entity_address, :validator_address, :epoch_unlock])

    body =
      []
      |> Request.DeriveEntityIdentifier.network_identifier(network)
      |> Request.DeriveEntityIdentifier.public_key(hex: public_key)
      |> Request.DeriveEntityIdentifier.Metadata.ExitingUnstakes.type()
      |> Request.DeriveEntityIdentifier.Metadata.ExitingUnstakes.validator(
        address: validator_address
      )
      |> Util.maybe_create_stitch_plan(
        sub_entity,
        &Request.DeriveEntityIdentifier.Metadata.ExitingUnstakes.sub_entity/2
      )
      |> Request.DeriveEntityIdentifier.Metadata.ExitingUnstakes.epoch_unlock(
        epoch_unlock: epoch_unlock
      )
      |> Util.stitch()

    API.derive_entity_identifier(body, Keyword.get(options, :api, []))
  end

  @doc """
  Derives `ValidatorSystem` entity identifier.

  ## Parameters
    - `public_key`: Public key.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec derive_validator_system_entity_identifier(public_key, options) ::
          {:ok, map} | {:error, map | error_message}
  def derive_validator_system_entity_identifier(public_key, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.DeriveEntityIdentifier.network_identifier(network)
      |> Request.DeriveEntityIdentifier.public_key(hex: public_key)
      |> Request.DeriveEntityIdentifier.Metadata.ValidatorSystem.type()
      |> Util.stitch()

    API.derive_entity_identifier(body, Keyword.get(options, :api, []))
  end

  @doc """
  Builds type map in an operation.

  ## Parameters
    - `type`: Can be Resource, Data, or ResourceAndData.
  """
  @spec build_operation_type(type) :: map
  def build_operation_type(type) do
    []
    |> Request.BuildTransaction.Operation.type(type: type)
    |> Util.stitch()
  end

  @doc """
  Builds entity identifier map in operation.

  ## Parameters
    - `address`: Radix address.
    - `options`: Keyword list that contains
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
  """
  @spec build_operation_entity_identifier(address, options) :: map
  def build_operation_entity_identifier(address, options \\ []) do
    sub_entity = Keyword.take(options, [:sub_entity_address, :validator_address, :epoch_unlock])

    []
    |> Request.BuildTransaction.Operation.entity_identifier(address: address)
    |> Util.maybe_create_stitch_plan(sub_entity, &Request.BuildTransaction.Operation.sub_entity/2)
    |> Util.stitch()
  end

  @doc """
  Builds substate map in operation.

  ## Parameters
    - `substate_operation`: Substate operation - can be "BOOTUP" or "SHUTDOWN".
    - `substate_identifier`: Substate identifier
  """
  @spec build_operation_substate(substate_operation, substate_identifier) :: map
  def build_operation_substate(substate_operation, substate_identifier) do
    []
    |> Request.BuildTransaction.Operation.substate(
      substate_operation: substate_operation,
      identifier: substate_identifier
    )
    |> Util.stitch()
  end

  @doc """
  Builds amount map in operation where resource type is token.

  ## Parameters
    - `amount`: Amount.
    - `rri`: Token rri.
  """
  @spec build_operation_amount_token(amount, rri) :: map
  def build_operation_amount_token(amount, rri) do
    []
    |> Request.BuildTransaction.Operation.amount(amount: amount)
    |> Request.BuildTransaction.Operation.ResourceIdentifier.token(rri: rri)
    |> Util.stitch()
  end

  @doc """
  Builds amount map in operation where resource type is stake unit.

  ## Parameters
    - `amount`: Amount.
    - `validator_address`: Validator addres.
  """
  @spec build_operation_amount_stake_unit(amount, validator_address) :: map
  def build_operation_amount_stake_unit(amount, validator_address) do
    []
    |> Request.BuildTransaction.Operation.amount(amount: amount)
    |> Request.BuildTransaction.Operation.ResourceIdentifier.stake_unit(
      validator_address: validator_address
    )
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data type is UnclaimedRadixEngineAddress.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
  """
  @spec build_operation_data_unclaimed_radix_engine_address(action) :: map
  def build_operation_data_unclaimed_radix_engine_address(action) do
    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.UnclaimedRadixEngineAddress.type()
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data type is RoundData.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `round`: Round
    - `timestamp`: Timestamp
  """
  @spec build_operation_data_round_data(action, round, timestamp) :: map
  def build_operation_data_round_data(action, round, timestamp) do
    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.RoundData.type()
    |> Request.BuildTransaction.Operation.DataObject.RoundData.round(round: round)
    |> Request.BuildTransaction.Operation.DataObject.RoundData.timestamp(timestamp: timestamp)
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data type is EpochData.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `epoch`: Epoch
  """
  @spec build_operation_data_epoch_data(action, epoch) :: map
  def build_operation_data_epoch_data(action, epoch) do
    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.EpochData.type()
    |> Request.BuildTransaction.Operation.DataObject.EpochData.epoch(epoch: epoch)
    |> Util.stitch()
  end

  @doc """
  Builds metadata map in operation.

  ## Parameters
    - `substate_data_hex`: Substate data hex.
  """
  @spec build_operation_metadata(substate_data_hex) :: map
  def build_operation_metadata(substate_data_hex) do
    []
    |> Request.BuildTransaction.Operation.metadata(substate_data_hex: substate_data_hex)
    |> Util.stitch()
  end

  @doc """
  Builds an operation.

  ## Parameters
    - `type`: Type map - can be Resource, Data, or ResourceAndData.
    - `entity_identifier`: Fee payer address.
    - `options`: Keyword list that contains
      - `substate` (optional, map): Substate map.
      - `amount` (optional, map): Amount map.
      - `data` (optional, map): Data map.
      - `metadata` (optional, map): Metadata map.
  """
  def build_operation(type, entity_identifier, options \\ []) do
  end

  @spec build_operation_group(list(map)) :: map
  def build_operation_group(operations) do
    Request.BuildTransaction.OperationGroup.create(operations)
  end

  @doc """
  Builds a transaction.

  ## Parameters
    - `operation_groups`: Operation groups.
    - `fee_payer_address`: Fee payer address.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_resource_allocate_and_destroy` (optional, boolean): Disable resource allocate and destroy.
  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec build_transaction(
          operation_groups,
          fee_payer_address,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def build_transaction(
        operation_groups,
        fee_payer_address,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])
    sub_entity = Keyword.take(options, [:sub_entity_address, :validator_address, :epoch_unlock])
    message = Keyword.take(options, [:message])

    disable_resource_allocate_and_destroy =
      Keyword.take(options, [:disable_resource_allocate_and_destroy])

    body =
      []
      |> Request.BuildTransaction.network_identifier(network)
      |> Request.BuildTransaction.fee_payer(address: fee_payer_address)
      |> Util.maybe_create_stitch_plan(sub_entity, &Request.BuildTransaction.sub_entity/2)
      |> Util.maybe_create_stitch_plan(message, &Request.BuildTransaction.message/2)
      |> Util.maybe_create_stitch_plan(
        disable_resource_allocate_and_destroy,
        &Request.BuildTransaction.disable_resource_allocate_and_destroy/2
      )
      |> Util.stitch()

    body = Request.BuildTransaction.add_operation_groups(body, operation_groups)

    API.build_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Parses a transaction.

  ## Parameters
    - `transaction`: Transaction to parse.
    - `signed`: Whether the transaction is signed or not.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec parse_transaction(transaction, signed, options) ::
          {:ok, map} | {:error, map | error_message}
  def parse_transaction(transaction, signed, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.ParseTransaction.network_identifier(network)
      |> Request.ParseTransaction.transaction(transaction: transaction)
      |> Request.ParseTransaction.signed(signed: signed)
      |> Util.stitch()

    API.parse_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Finalizes a transaction.

  ## Parameters
    - `unsigned_transaction`: Unsigned ransaction.
    - `signature_bytes`: Signature bytes.
    - `signature_public_key`: Signature public key.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec finalize_transaction(unsigned_transaction, signature_bytes, signature_public_key, options) ::
          {:ok, map} | {:error, map | error_message}
  def finalize_transaction(
        unsigned_transaction,
        signature_bytes,
        signature_public_key,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.FinalizeTransaction.network_identifier(network)
      |> Request.FinalizeTransaction.unsigned_transaction(
        unsigned_transaction: unsigned_transaction
      )
      |> Request.FinalizeTransaction.signature(hex: signature_public_key, bytes: signature_bytes)
      |> Util.stitch()

    API.finalize_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Gets transaction hash.

  ## Parameters
    - `signed_transaction`: Signed ransaction.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec get_transaction_hash(signed_transaction, options) ::
          {:ok, map} | {:error, map | error_message}
  def get_transaction_hash(
        signed_transaction,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.GetTransactionHash.network_identifier(network)
      |> Request.GetTransactionHash.signed_transaction(signed_transaction: signed_transaction)
      |> Util.stitch()

    API.get_transaction_hash(body, Keyword.get(options, :api, []))
  end

  @doc """
  Submits a transaction.

  ## Parameters
    - `signed_transaction`: Signed ransaction.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec submit_transaction(signed_transaction, options) ::
          {:ok, map} | {:error, map | error_message}
  def submit_transaction(
        signed_transaction,
        options \\ []
      ) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.SubmitTransaction.network_identifier(network)
      |> Request.SubmitTransaction.signed_transaction(signed_transaction: signed_transaction)
      |> Util.stitch()

    API.submit_transaction(body, Keyword.get(options, :api, []))
  end

  @doc """
  Signs a transaction.

  ## Parameters
    - `unsigned_transaction`: Unsigned Transaction.
    - `public_key`: Public key.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If `url` is not in `options` then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, string): `auth_index` is the index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): `username` to be used for endpoint authentication.
        - `password`: (optional, string): `password` to be used for endpoint authentication.
      - `network` (optional, string): If `network` is not in `options` it will default to what is returned from `Radixir.Config.network()`.

  ## Note
    - Either `username` and `password` or `auth_index` must be provided.
    - If all three are provided `auth_index` is used.
  """
  @spec sign_transaction(unsigned_transaction, public_key, options) ::
          {:ok, map} | {:error, map | error_message}
  def sign_transaction(unsigned_transaction, public_key, options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.SignTransaction.network_identifier(network)
      |> Request.SignTransaction.unsigned_transaction(unsigned_transaction: unsigned_transaction)
      |> Request.SignTransaction.public_key(hex: public_key)
      |> Util.stitch()

    API.sign_transaction(body, Keyword.get(options, :api, []))
  end
end
