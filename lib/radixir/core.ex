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
  @type granularity :: integer
  @type is_mutable :: boolean
  @type registered :: boolean
  @type fee :: integer
  @type name :: String.t()
  @type url :: String.t()
  @type proposals_completed :: integer
  @type proposals_missed :: integer
  @type allow_delegation :: boolean
  @type data :: String.t()

  @doc """
  Gets network configuration.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
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
  @spec get_network_configuration(options) :: {:ok, map} | {:error, map | error_message}
  def get_network_configuration(options \\ []),
    do: API.get_network_configuration(Keyword.get(options, :api, []))

  @doc """
  Gets network status.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `transaction_accumulator` (optional, string): Transaction accumulator in state identifier map.
      - `limit` (optional, integer): Maximum number of transactions that will be returned.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
  Builds data map in operation where data object type is UnclaimedRadixEngineAddress.

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
  Builds data map in operation where data object type is RoundData.

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
  Builds data map in operation where data object type is EpochData.

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
  Builds data map in operation where data object type is TokenData.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `granularity`: Granularity
    - `is_mutable`: If the token is mutable.
    - `options`: Keyword list that contains
      - `address` (optional, string): Owner address
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
  """
  @spec build_operation_data_token_data(action, granularity, is_mutable, options) :: map
  def build_operation_data_token_data(action, granularity, is_mutable, options \\ []) do
    owner_address = Keyword.take(options, [:address])

    sub_entity = Keyword.take(options, [:sub_entity_address, :validator_address, :epoch_unlock])

    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.TokenData.type()
    |> Request.BuildTransaction.Operation.DataObject.TokenData.granularity(
      granularity: granularity
    )
    |> Request.BuildTransaction.Operation.DataObject.TokenData.is_mutable(is_mutable: is_mutable)
    |> Util.maybe_create_stitch_plan(
      owner_address,
      &Request.BuildTransaction.Operation.DataObject.TokenData.owner/2
    )
    |> Util.maybe_create_stitch_plan(
      sub_entity,
      &Request.BuildTransaction.Operation.DataObject.TokenData.sub_entity/2
    )
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data object type is TokenMetaData.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `symbol`: Token symbol
    - `options`: Keyword list that contains
      - `name` (optional, string): Token name.
      - `description` (optional, string): Token description.
      - `url` (optional, string): Token url.
      - `icon_url` (optional, string): Token icon_url.
  """
  @spec build_operation_data_token_metadata(action, symbol, options) :: map
  def build_operation_data_token_metadata(action, symbol, options \\ []) do
    name = Keyword.take(options, [:name])
    description = Keyword.take(options, [:description])
    url = Keyword.take(options, [:url])
    icon_url = Keyword.take(options, [:icon_url])

    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.TokenMetaData.type()
    |> Request.BuildTransaction.Operation.DataObject.TokenMetaData.symbol(symbol: symbol)
    |> Util.maybe_create_stitch_plan(
      name,
      &Request.BuildTransaction.Operation.DataObject.TokenMetaData.name/2
    )
    |> Util.maybe_create_stitch_plan(
      description,
      &Request.BuildTransaction.Operation.DataObject.TokenMetaData.description/2
    )
    |> Util.maybe_create_stitch_plan(
      url,
      &Request.BuildTransaction.Operation.DataObject.TokenMetaData.url/2
    )
    |> Util.maybe_create_stitch_plan(
      icon_url,
      &Request.BuildTransaction.Operation.DataObject.TokenMetaData.icon_url/2
    )
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data object type is TokenMetaData.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `symbol`: Token symbol
    - `options`: Keyword list that contains
      - `epoch` (options, integer): Epoch.

  """
  @spec build_operation_data_prepared_validator_registered(action, registered, options) :: map
  def build_operation_data_prepared_validator_registered(action, registered, options \\ []) do
    epoch = Keyword.take(options, [:epoch])

    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.PreparedValidatorRegistered.type()
    |> Request.BuildTransaction.Operation.DataObject.PreparedValidatorRegistered.registered(
      registered: registered
    )
    |> Util.maybe_create_stitch_plan(
      epoch,
      &Request.BuildTransaction.Operation.DataObject.PreparedValidatorRegistered.epoch/2
    )
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data object type is PreparedValidatorOwner.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `address`: Owner address
    - `options`: Keyword list that contains
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
  """
  @spec build_operation_data_prepared_validator_owner(action, address, options) :: map
  def build_operation_data_prepared_validator_owner(action, address, options \\ []) do
    sub_entity = Keyword.take(options, [:sub_entity_address, :validator_address, :epoch_unlock])

    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.PreparedValidatorOwner.type()
    |> Request.BuildTransaction.Operation.DataObject.PreparedValidatorOwner.owner(
      address: address
    )
    |> Util.maybe_create_stitch_plan(
      sub_entity,
      &Request.BuildTransaction.Operation.DataObject.PreparedValidatorOwner.sub_entity/2
    )
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data object type is PreparedValidatorFee.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `fee`: Validator fee.
    - `options`: Keyword list that contains
      - `epoch` (optional, integer): Epoch.
  """
  @spec build_operation_data_prepared_validator_fee(action, fee, options) :: map
  def build_operation_data_prepared_validator_fee(action, fee, options \\ []) do
    epoch = Keyword.take(options, [:epoch])

    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.PreparedValidatorFee.type()
    |> Request.BuildTransaction.Operation.DataObject.PreparedValidatorFee.fee(fee: fee)
    |> Util.maybe_create_stitch_plan(
      epoch,
      &Request.BuildTransaction.Operation.DataObject.PreparedValidatorFee.epoch/2
    )
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data object type is ValidatorMetadata.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `name`: Validator name.
    - `url`: Validator url.
  """
  @spec build_operation_data_validator_metadata(action, name, url) :: map
  def build_operation_data_validator_metadata(action, name, url) do
    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.ValidatorMetadata.name(name: name)
    |> Request.BuildTransaction.Operation.DataObject.ValidatorMetadata.url(url: url)
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data object type is ValidatorBFTData.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `proposals_completed`: Number of completed proposals by this validator as a leader in the current epoch.
    - `proposals_missed`:  Number of missed proposals by this validator as a leader in the current epoch.
  """
  @spec build_operation_data_validator_bft_data(action, proposals_completed, proposals_missed) ::
          map
  def build_operation_data_validator_bft_data(action, proposals_completed, proposals_missed) do
    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.ValidatorBFTdata.proposals_completed(
      proposals_completed: proposals_completed
    )
    |> Request.BuildTransaction.Operation.DataObject.ValidatorBFTdata.proposals_missed(
      proposals_missed: proposals_missed
    )
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data object type is ValidatorAllowDelegation.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `allow_delegation`: If validator allows delegation.
  """
  @spec build_operation_data_validator_allow_delegation(action, allow_delegation) ::
          map
  def build_operation_data_validator_allow_delegation(action, allow_delegation) do
    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.ValidatorAllowDelegation.allow_delegation(
      allow_delegation: allow_delegation
    )
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data object type is ValidatorData.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `address`: Owner address
    - `registered`: If validator is registered or not.
    - `fee`: Validator fee.
    - `options`: Keyword list that contains
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
  """
  @spec build_operation_data_prepared_validator_data(action, address, registered, fee, options) ::
          map
  def build_operation_data_prepared_validator_data(
        action,
        address,
        registered,
        fee,
        options \\ []
      ) do
    sub_entity = Keyword.take(options, [:sub_entity_address, :validator_address, :epoch_unlock])

    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.ValidatorData.type()
    |> Request.BuildTransaction.Operation.DataObject.ValidatorData.owner(address: address)
    |> Util.maybe_create_stitch_plan(
      sub_entity,
      &Request.BuildTransaction.Operation.DataObject.ValidatorData.sub_entity/2
    )
    |> Request.BuildTransaction.Operation.DataObject.ValidatorData.registered(
      registered: registered
    )
    |> Request.BuildTransaction.Operation.DataObject.ValidatorData.fee(fee: fee)
    |> Util.stitch()
  end

  @doc """
  Builds data map in operation where data object type is ValidatorSystemMetadata.

  ## Parameters
    - `action`: Action - can be "CREATE" or "DELETE".
    - `data`: Hex encoded byte array.
  """
  @spec build_operation_data_validator_system_metadata(action, data) ::
          map
  def build_operation_data_validator_system_metadata(action, data) do
    []
    |> Request.BuildTransaction.Operation.data(action: action)
    |> Request.BuildTransaction.Operation.DataObject.ValidatorSystemMetadata.data(data: data)
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
    - `type`: Type map.
    - `entity_identifier`: Entity identifier map.
    - `options`: Keyword list that contains
      - `substate` (optional, map): Substate map.
      - `amount` (optional, map): Amount map.
      - `data` (optional, map): Data map.
      - `metadata` (optional, map): Metadata map.
  """
  def build_operation(type, entity_identifier, options \\ []) do
    substate = Keyword.get(options, :substate, %{})
    amount = Keyword.get(options, :amount, %{})
    data = Keyword.get(options, :data, %{})
    metadata = Keyword.get(options, :metadata, %{})

    type
    |> Map.merge(entity_identifier)
    |> Map.merge(substate)
    |> Map.merge(amount)
    |> Map.merge(data)
    |> Map.merge(metadata)
  end

  @doc """
  Builds an operation group.

  ## Parameters
    - `operations`: List of operation maps.
  """
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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_resource_allocate_and_destroy` (optional, boolean): Disable resource allocate and destroy.
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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
    - `signature_public_key`: Signature public key.
    - `signature_bytes`: Signature bytes.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
  @spec finalize_transaction(unsigned_transaction, signature_public_key, signature_bytes, options) ::
          {:ok, map} | {:error, map | error_message}
  def finalize_transaction(
        unsigned_transaction,
        signature_public_key,
        signature_bytes,
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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
  Gets public keys.

  ## Parameters
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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
  @spec get_public_keys(options) ::
          {:ok, map} | {:error, map | error_message}
  def get_public_keys(options \\ []) do
    network = Keyword.take(options, [:network])

    body =
      []
      |> Request.GetPublicKeys.network_identifier(network)
      |> Util.stitch()

    API.get_public_keys(body, Keyword.get(options, :api, []))
  end

  @doc """
  Signs a transaction.

  ## Parameters
    - `unsigned_transaction`: Unsigned Transaction.
    - `public_key`: Public key.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.

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

  @doc """
  Sends a transaction.

  ## Parameters
    - `operation_groups`: Operation groups.
    - `fee_payer_address`: Fee payer address.
    - `private_key`: Private key to sign transaction.
    - `options`: Keyword list that contains
      - `api`: Keyword list that contains
        - `url` (optional, string): If url is not in options then the url set in the configs will be used.
        - any other options one may want to pass along to the http layer - for example `headers`
        - `auth_index` (optional, integer): Index of the username + password combo to be used for endpoint authentication.
        - `username`: (optional, string): Username to be used for endpoint authentication.
        - `password`: (optional, string): Password to be used for endpoint authentication.
      - `network` (optional, string): If network is not in options it will default to what is returned from `Radixir.Config.network()`.
      - `sub_entity_address` (optional, string): Sub entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
      - `message` (optional, string): Message to be included in transaction.
      - `disable_resource_allocate_and_destroy` (optional, boolean): Disable resource allocate and destroy.
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
  @spec send_transaction(
          operation_groups,
          fee_payer_address,
          private_key,
          options
        ) ::
          {:ok, map} | {:error, map | error_message}
  def send_transaction(
        operation_groups,
        fee_payer_address,
        private_key,
        options \\ []
      ) do
    with {:ok, %{public_key: public_key}} <- Key.from_private_key(private_key),
         {:ok, built_transaction} <-
           build_transaction(
             operation_groups,
             fee_payer_address,
             options
           ),
         :ok <-
           Util.verify_hash(
             built_transaction["unsigned_transaction"],
             built_transaction["payload_to_sign"]
           ),
         {:ok, signature_bytes} <-
           Key.sign_data(built_transaction["payload_to_sign"], private_key),
         {:ok, finalized_transaction} <-
           finalize_transaction(
             built_transaction["unsigned_transaction"],
             public_key,
             signature_bytes,
             options
           ) do
      case submit_transaction(finalized_transaction["signed_transaction"], options) do
        {:ok, submitted_transaction} ->
          {:ok,
           %{
             build_transaction: built_transaction,
             finalize_transaction: finalized_transaction,
             submit_transaction: submitted_transaction
           }}

        {:error, error} ->
          {:error,
           %{
             succeeded: %{
               build_transaction: built_transaction,
               finalize_transaction: finalized_transaction
             },
             failed: %{submit_transaction: error}
           }}
      end
    end
  end
end
