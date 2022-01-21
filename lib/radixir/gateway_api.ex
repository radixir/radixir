defmodule Radixir.GatewayAPI do
  alias Radixir.Config
  alias Radixir.HTTP

  def get_info() do
    HTTP.post(Config.radix_gateway_api_url(), "/gateway", %{})
  end

  def derive_account_identifier(public_key_hex) do
    HTTP.post(Config.radix_gateway_api_url(), "/account/derive", %{
      network_identifier: %{
        network: Config.network()
      },
      public_key: %{
        hex: public_key_hex
      }
    })
  end

  def get_account_balances(address) do
    HTTP.post(Config.radix_gateway_api_url(), "/account/balances", %{
      network_identifier: %{
        network: Config.network()
      },
      account_identifier: %{
        address: address
      }
    })
  end

  def get_stake_positions(address) do
    HTTP.post(Config.radix_gateway_api_url(), "/account/stakes", %{
      network_identifier: %{
        network: Config.network()
      },
      account_identifier: %{
        address: address
      }
    })
  end

  def get_unstake_positions(address) do
    HTTP.post(Config.radix_gateway_api_url(), "/account/unstakes", %{
      network_identifier: %{
        network: Config.network()
      },
      account_identifier: %{
        address: address
      }
    })
  end

  def get_account_transactions(address, cursor, limit) do
    HTTP.post(Config.radix_gateway_api_url(), "/account/transactions", %{
      network_identifier: %{
        network: Config.network()
      },
      account_identifier: %{
        address: address
      },
      cursor: cursor,
      limit: limit
    })
  end

  def get_native_token_info() do
    HTTP.post(Config.radix_gateway_api_url(), "/token/native", %{
      network_identifier: %{
        network: Config.network()
      }
    })
  end

  def get_token_info(rri) do
    HTTP.post(Config.radix_gateway_api_url(), "/token", %{
      network_identifier: %{
        network: Config.network()
      },
      token_identifier: %{
        rri: rri
      }
    })
  end

  def derive_token_identifier(public_key_hex, symbol) do
    HTTP.post(Config.radix_gateway_api_url(), "/token/derive", %{
      network_identifier: %{
        network: Config.network()
      },
      public_key: %{
        hex: public_key_hex
      },
      symbol: symbol
    })
  end

  def get_validator(address) do
    HTTP.post(Config.radix_gateway_api_url(), "/validator", %{
      network_identifier: %{
        network: Config.network()
      },
      validator_identifier: %{
        address: address
      }
    })
  end

  def derive_validator_identifier(public_key_hex) do
    HTTP.post(Config.radix_gateway_api_url(), "/validator/derive", %{
      network_identifier: %{
        network: Config.network()
      },
      public_key: %{
        hex: public_key_hex
      }
    })
  end

  def get_validators() do
    HTTP.post(Config.radix_gateway_api_url(), "/validators", %{
      network_identifier: %{
        network: Config.network()
      }
    })
  end

  def get_transaction_rules() do
    HTTP.post(Config.radix_gateway_api_url(), "/transaction/rules", %{
      network_identifier: %{
        network: Config.network()
      }
    })
  end

  def build_transaction(actions, fee_payer_address, options \\ []) do
    disable_token_mint_and_burn = Keyword.get(options, :disable_token_mint_and_burn, true)

    HTTP.post(Config.radix_gateway_api_url(), "/transaction/build", %{
      network_identifier: %{
        network: Config.network()
      },
      actions: actions,
      fee_payer: %{address: fee_payer_address},
      disable_token_mint_and_burn: disable_token_mint_and_burn
    })
  end

  def finalize_transaction(unsigned_transaction, signature_bytes, public_key_hex, submit) do
    HTTP.post(Config.radix_gateway_api_url(), "/transaction/finalize", %{
      network_identifier: %{
        network: Config.network()
      },
      unsigned_transaction: unsigned_transaction,
      signature: %{bytes: signature_bytes, public_key: %{hex: public_key_hex}},
      submit: submit
    })
  end

  def submit_transaction(signed_transaction) do
    HTTP.post(Config.radix_gateway_api_url(), "/transaction/submit", %{
      network_identifier: %{
        network: Config.network()
      },
      signed_transaction: signed_transaction
    })
  end

  def get_transaction_status(transaction_identifier_hash) do
    HTTP.post(Config.radix_gateway_api_url(), "/transaction/status", %{
      network_identifier: %{
        network: Config.network()
      },
      transaction_identifier: %{hash: transaction_identifier_hash}
    })
  end
end
