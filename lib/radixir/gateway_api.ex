defmodule Radixir.GatewayAPI do
  alias Radixir.Config
  alias Radixir.HTTP
  alias Radixir.Utils

  def get_info() do
    HTTP.post(Config.radix_gateway_api_url(), "/gateway", %{},
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def derive_account_identifier(public_key_hex) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/account/derive",
      %{
        network_identifier: %{
          network: Config.network()
        },
        public_key: %{
          hex: public_key_hex
        }
      },
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def get_account_balances(account_identifier_address, options \\ []) do
    at_state_identifier = Keyword.get(options, :at_state_identifier, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        account_identifier: %{
          address: account_identifier_address
        }
      }
      |> Utils.maybe_put(:at_state_identifier, at_state_identifier)

    HTTP.post(Config.radix_gateway_api_url(), "/account/balances", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def get_stake_positions(account_identifier_address, options \\ []) do
    at_state_identifier = Keyword.get(options, :at_state_identifier, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        account_identifier: %{
          address: account_identifier_address
        }
      }
      |> Utils.maybe_put(:at_state_identifier, at_state_identifier)

    HTTP.post(Config.radix_gateway_api_url(), "/account/stakes", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def get_unstake_positions(account_identifier_address, options \\ []) do
    at_state_identifier = Keyword.get(options, :at_state_identifier, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        account_identifier: %{
          address: account_identifier_address
        }
      }
      |> Utils.maybe_put(:at_state_identifier, at_state_identifier)

    HTTP.post(Config.radix_gateway_api_url(), "/account/unstakes", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def get_account_transactions(account_identifier_address, options \\ []) do
    at_state_identifier = Keyword.get(options, :at_state_identifier, nil)
    cursor = Keyword.get(options, :cursor, nil)
    limit = Keyword.get(options, :limit, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        account_identifier: %{
          address: account_identifier_address
        }
      }
      |> Utils.maybe_put(:at_state_identifier, at_state_identifier)
      |> Utils.maybe_put(:cursor, cursor)
      |> Utils.maybe_put(:limit, limit)

    HTTP.post(Config.radix_gateway_api_url(), "/account/transactions", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def get_native_token_info(options \\ []) do
    at_state_identifier = Keyword.get(options, :at_state_identifier, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        }
      }
      |> Utils.maybe_put(:at_state_identifier, at_state_identifier)

    HTTP.post(Config.radix_gateway_api_url(), "/token/native", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def get_token_info(token_identifier_rri, options \\ []) do
    at_state_identifier = Keyword.get(options, :at_state_identifier, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        token_identifier: %{
          rri: token_identifier_rri
        }
      }
      |> Utils.maybe_put(:at_state_identifier, at_state_identifier)

    HTTP.post(Config.radix_gateway_api_url(), "/token", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def derive_token_identifier(public_key_hex, symbol) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/token/derive",
      %{
        network_identifier: %{
          network: Config.network()
        },
        public_key: %{
          hex: public_key_hex
        },
        symbol: symbol
      },
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def get_validator(validator_identifier_address, options \\ []) do
    at_state_identifier = Keyword.get(options, :at_state_identifier, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        validator_identifier: %{
          address: validator_identifier_address
        }
      }
      |> Utils.maybe_put(:at_state_identifier, at_state_identifier)

    HTTP.post(Config.radix_gateway_api_url(), "/validator", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def derive_validator_identifier(public_key_hex) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/validator/derive",
      %{
        network_identifier: %{
          network: Config.network()
        },
        public_key: %{
          hex: public_key_hex
        }
      },
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def get_validators(options \\ []) do
    at_state_identifier = Keyword.get(options, :at_state_identifier, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        }
      }
      |> Utils.maybe_put(:at_state_identifier, at_state_identifier)

    HTTP.post(Config.radix_gateway_api_url(), "/validators", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def get_transaction_rules(options \\ []) do
    at_state_identifier = Keyword.get(options, :at_state_identifier, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        }
      }
      |> Utils.maybe_put(:at_state_identifier, at_state_identifier)

    HTTP.post(Config.radix_gateway_api_url(), "/transaction/rules", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def build_transaction(actions, fee_payer_address, options \\ []) do
    at_state_identifier = Keyword.get(options, :at_state_identifier, nil)
    message = Keyword.get(options, :message, nil)
    disable_token_mint_and_burn = Keyword.get(options, :disable_token_mint_and_burn, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        actions: actions,
        fee_payer: %{address: fee_payer_address}
      }
      |> Utils.maybe_put(:at_state_identifier, at_state_identifier)
      |> Utils.maybe_put(:message, message)
      |> Utils.maybe_put(:disable_token_mint_and_burn, disable_token_mint_and_burn)

    HTTP.post(Config.radix_gateway_api_url(), "/transaction/build", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def finalize_transaction(unsigned_transaction, signature_bytes, public_key_hex, options \\ []) do
    submit = Keyword.get(options, :submit, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        unsigned_transaction: unsigned_transaction,
        signature: %{bytes: signature_bytes, public_key: %{hex: public_key_hex}}
      }
      |> Utils.maybe_put(:submit, submit)

    HTTP.post(Config.radix_gateway_api_url(), "/transaction/finalize", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def submit_transaction(signed_transaction) do
    HTTP.post(
      Config.radix_gateway_api_url(),
      "/transaction/submit",
      %{
        network_identifier: %{
          network: Config.network()
        },
        signed_transaction: signed_transaction
      },
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end

  def get_transaction_status(transaction_identifier_hash, options \\ []) do
    at_state_identifier = Keyword.get(options, :at_state_identifier, nil)

    body =
      %{
        network_identifier: %{
          network: Config.network()
        },
        transaction_identifier: %{hash: transaction_identifier_hash}
      }
      |> Utils.maybe_put(:at_state_identifier, at_state_identifier)

    HTTP.post(Config.radix_gateway_api_url(), "/transaction/status", body,
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
  end
end
