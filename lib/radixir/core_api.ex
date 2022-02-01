defmodule Radixir.CoreAPI do
  alias Radixir.Config
  alias Radixir.HTTP
  alias Radixir.Utils

  def get_network_configuration() do
    HTTP.post(
      Config.radix_core_api_url(),
      "/network/configuration",
      %{},
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_network_status() do
    HTTP.post(
      Config.radix_core_api_url(),
      "/network/status",
      %{
        network_identifier: %{
          network: Config.network()
        }
      },
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_entity_information(address, options \\ []) do
    sub_entity = Keyword.get(options, :sub_entity, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        entity_identifier: %{
          address: address
        }
      }
      |> Utils.maybe_put_in([:entity_indentifier, :sub_entity], sub_entity)

    HTTP.post(
      Config.radix_core_api_url(),
      "/entity",
      body,
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_mempool_transactions() do
    HTTP.post(
      Config.radix_core_api_url(),
      "/mempool",
      %{
        network_identifier: %{
          network: Config.network()
        }
      },
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_mempool_transaction(transaction_identifier_hash) do
    HTTP.post(
      Config.radix_core_api_url(),
      "/mempool/transaction",
      %{
        network_identifier: %{
          network: Config.network()
        },
        transaction_identifier: %{
          hash: transaction_identifier_hash
        }
      },
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_committed_transactions(state_version, options \\ []) do
    transaction_accumulator = Keyword.get(options, :transaction_accumulator, nil)
    limit = Keyword.get(options, :limit, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        state_identifier: %{
          state_version: state_version
        }
      }
      |> Utils.maybe_put(:limit, limit)
      |> Utils.maybe_put_in(
        [:state_indentifier, :transaction_accumulator],
        transaction_accumulator
      )

    HTTP.post(
      Config.radix_core_api_url(),
      "/transactions",
      body,
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def derive_entity_identifier(public_key_hex, metatdata) do
    HTTP.post(
      Config.radix_core_api_url(),
      "/construction/derive",
      %{
        network_identifier: %{
          network: Config.network()
        },
        public_key: %{
          hex: public_key_hex
        },
        metatdata: metatdata
      },
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def build_transaction(operation_groups, fee_payer, options \\ []) do
    message = Keyword.get(options, :message, nil) |> Utils.encode_message()

    disable_resource_allocate_and_destroy =
      Keyword.get(options, :disable_resource_allocate_and_destroy, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        operation_groups: operation_groups,
        fee_payer: fee_payer
      }
      |> Utils.maybe_put(:message, message)
      |> Utils.maybe_put(
        :disable_resource_allocate_and_destroy,
        disable_resource_allocate_and_destroy
      )

    HTTP.post(
      Config.radix_core_api_url(),
      "/construction/build",
      body,
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def parse_transaction(transaction, signed) do
    HTTP.post(
      Config.radix_core_api_url(),
      "/construction/parse",
      %{
        network_identifier: %{
          network: Config.network()
        },
        transaction: transaction,
        signed: signed
      },
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def finalize_transaction(unsigned_transaction, public_key_hex, signature_bytes) do
    HTTP.post(
      Config.radix_core_api_url(),
      "/construction/finalize",
      %{
        network_identifier: %{
          network: Config.network()
        },
        unsigned_transaction: unsigned_transaction,
        signature: %{public_key: %{hex: public_key_hex}, bytes: signature_bytes}
      },
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_transaction_hash(signed_transaction) do
    HTTP.post(
      Config.radix_core_api_url(),
      "/construction/hash",
      %{
        network_identifier: %{
          network: Config.network()
        },
        signed_transaction: signed_transaction
      },
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def submit_transaction(signed_transaction) do
    HTTP.post(
      Config.radix_core_api_url(),
      "/construction/submit",
      %{
        network_identifier: %{
          network: Config.network()
        },
        signed_transaction: signed_transaction
      },
      auth: {"admin", Config.radix_admin_password()}
    )
  end

  def get_public_keys() do
    HTTP.post(
      Config.radix_core_api_url(),
      "/key/list",
      %{
        network_identifier: %{
          network: Config.network()
        }
      },
      auth: {"superadmin", Config.radix_superadmin_password()}
    )
  end

  def sign_transaction(unsigned_transaction, public_key_hex) do
    HTTP.post(
      Config.radix_core_api_url(),
      "/key/sign",
      %{
        network_identifier: %{
          network: Config.network()
        },
        unsigned_transaction: unsigned_transaction,
        public_key: %{hex: public_key_hex}
      },
      auth: {"superadmin", Config.radix_superadmin_password()}
    )
  end
end
