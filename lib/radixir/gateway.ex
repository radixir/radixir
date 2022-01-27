defmodule Radixir.Gateway do
  alias Radixir.GatewayAPI
  alias Radixir.Utils

  def build_transfer_tokens_transaction(from, to, value, rri) do
    actions = [
      build_transfer_tokens_action(%{
        from_address: from,
        to_address: to,
        value: value,
        rri: rri
      })
    ]

    with {:ok,
          %{
            "transaction_build" => %{
              "payload_to_sign" => payload_to_sign,
              "unsigned_transaction" => unsigned_transaction
            }
          }} = results <-
           GatewayAPI.build_transaction(actions, from),
         :ok <- Utils.verify_hash(unsigned_transaction, payload_to_sign) do
      results
    end
  end

  def build_transfer_xrd_transaction(from, to, value) do
    with {:ok, %{"token" => %{"token_identifier" => %{"rri" => rri}}}} <-
           GatewayAPI.get_native_token_info() do
      build_transfer_tokens_transaction(from, to, value, rri)
    end
  end

  def build_create_tokens_action(params) do
    %{
      type: "CreateTokenDefinition",
      token_properties: %{
        name: params.name,
        description: params.description,
        icon_url: params.icon_url,
        url: params.url,
        symbol: params.symbol,
        is_supply_mutable: params.is_supply_mutable,
        granularity: params.grandularity,
        owner: %{address: params.owner_address}
      },
      token_supply: %{
        value: params.value,
        token_identifier: %{rri: params.rri}
      },
      to_account: %{address: params.to_address}
    }
  end

  def build_transfer_tokens_action(params) do
    %{
      type: "TransferTokens",
      from_account: %{
        address: params.from_address
      },
      to_account: %{
        address: params.to_address
      },
      amount: %{
        value: params.value,
        token_identifier: %{
          rri: params.rri
        }
      }
    }
  end

  def build_stake_tokens_action(params) do
    %{
      type: "StakeTokens",
      from_account: %{
        address: params.from_address
      },
      to_validator: %{
        address: params.validator_address
      },
      amount: %{
        value: params.value,
        token_identifier: %{
          rri: params.rri
        }
      }
    }
  end

  def build_unstake_tokens_action(params, options \\ []) do
    unstake_percentage = Keyword.get(options, :unstake_percentage, nil)

    %{
      type: "UnstakeTokens",
      from_validator: %{
        address: params.validator_address
      },
      to_account: %{
        address: params.to_address
      },
      amount: %{
        value: params.value,
        token_identifier: %{
          rri: params.rri
        }
      }
    }
    |> Utils.maybe_put(:unstake_percentage, unstake_percentage)
  end

  def build_mint_tokens_action(params) do
    %{
      type: "MintTokens",
      to_account: %{
        address: params.to_address
      },
      amount: %{
        value: params.value,
        token_identifier: %{
          rri: params.rri
        }
      }
    }
  end

  def build_burn_tokens_action(params) do
    %{
      type: "BurnTokens",
      from_account: %{
        address: params.from_address
      },
      amount: %{
        value: params.value,
        token_identifier: %{
          rri: params.rri
        }
      }
    }
  end
end
