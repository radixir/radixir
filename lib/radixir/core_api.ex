defmodule Radixir.CoreAPI do
  alias Radixir.Config
  alias Radixir.HTTP

  def get_network_configuration() do
    HTTP.post(Config.radix_core_api_url(), "/network/configuration", %{})
  end

  def get_network_status() do
    HTTP.post(Config.radix_core_api_url(), "/network/status", %{
      network_identifier: %{
        network: Config.network()
      }
    })
  end

  def get_entity_information(address) do
    HTTP.post(Config.radix_core_api_url(), "/entity", %{
      network_identifier: %{
        network: Config.network()
      },
      entity_identifier: %{
        address: address
      }
    })
  end

  def get_mempool_transactions() do
    HTTP.post(Config.radix_core_api_url(), "/mempool", %{
      network_identifier: %{
        network: Config.network()
      }
    })
  end

  def get_mempool_transaction(transaction_identifier_hash) do
    HTTP.post(Config.radix_core_api_url(), "/mempool/transaction", %{
      network_identifier: %{
        network: Config.network()
      },
      transaction_identifier: %{
        hash: transaction_identifier_hash
      }
    })
  end

  def get_committed_transactions(state_version, limit) do
    HTTP.post(Config.radix_core_api_url(), "/transactions", %{
      network_identifier: %{
        network: Config.network()
      },
      state_identifier: %{
        state_version: state_version
      },
      limit: limit
    })
  end

  def derive_entity_identifier(public_key_hex, metatdata) do
    HTTP.post(Config.radix_core_api_url(), "/construction/derive", %{
      network_identifier: %{
        network: Config.network()
      },
      public_key: %{
        hex: public_key_hex
      },
      metatdata: metatdata
    })
  end

  def build_transaction(operation_groups, fee_payer_address, options \\ []) do
    message = Keyword.get(options, :message, "")

    disable_resource_allocate_and_destroy =
      Keyword.get(options, :disable_resource_allocate_and_destroy, true)

    HTTP.post(Config.radix_core_api_url(), "/construction/build", %{
      network_identifier: %{
        network: Config.network()
      },
      operation_groups: operation_groups,
      fee_payer: %{
        address: fee_payer_address
      },
      message: message,
      disable_resource_allocate_and_destroy: disable_resource_allocate_and_destroy
    })
  end

  def parse_transaction(transaction, signed) do
    HTTP.post(Config.radix_core_api_url(), "/construction/parse", %{
      network_identifier: %{
        network: Config.network()
      },
      transaction: transaction,
      signed: signed
    })
  end

  def finalize_transaction(unsigned_transaction, public_key_hex, signature_bytes) do
    HTTP.post(Config.radix_core_api_url(), "/construction/finalize", %{
      network_identifier: %{
        network: Config.network()
      },
      unsigned_transaction: unsigned_transaction,
      signature: %{public_key: %{hex: public_key_hex}, bytes: signature_bytes}
    })
  end

  def get_transaction_hash(signed_transaction) do
    HTTP.post(Config.radix_core_api_url(), "/construction/hash", %{
      network_identifier: %{
        network: Config.network()
      },
      signed_transaction: signed_transaction
    })
  end

  def submit_transaction(signed_transaction) do
    HTTP.post(Config.radix_core_api_url(), "/construction/submit", %{
      network_identifier: %{
        network: Config.network()
      },
      signed_transaction: signed_transaction
    })
  end

  def get_public_keys() do
    HTTP.post(Config.radix_core_api_url(), "/key/list", %{
      network_identifier: %{
        network: Config.network()
      }
    })
  end

  def sign_transaction(unsigned_transaction, public_key_hex) do
    HTTP.post(Config.radix_core_api_url(), "/key/sign", %{
      network_identifier: %{
        network: Config.network()
      },
      unsigned_transaction: unsigned_transaction,
      public_key: %{hex: public_key_hex}
    })
  end
end
