defmodule Radixir.Schema.Gateway do
  @moduledoc false

  use Xema, multi: true

  @public_key {:string, min_length: 66, max_length: 66, pattern: "^[a-fA-F0-9]+$"}
  @address {:string, min_length: 65, max_length: 65, pattern: "^rdx|txd"}

  xema :derive_account_identifier do
    map(
      keys: :atoms,
      properties: %{
        network_identifier:
          map(
            keys: :atoms,
            properties: %{
              network: {:string, min_length: 1}
            },
            required: [:network],
            additional_properties: false
          ),
        public_key:
          map(
            keys: :atoms,
            properties: %{
              hex: @public_key
            },
            required: [:hex],
            additional_properties: false
          )
      },
      required: [:network_identifier, :public_key],
      additional_properties: false
    )
  end

  xema :get_account_balances do
    map(
      keys: :atoms,
      properties: %{
        network_identifier:
          map(
            keys: :atoms,
            properties: %{
              network: {:string, min_length: 1}
            },
            required: [:network],
            additional_properties: false
          ),
        account_identifier:
          map(
            keys: :atoms,
            properties: %{
              address: @address
            },
            required: [:address],
            additional_properties: false
          ),
        at_state_identifier:
          map(
            keys: :atoms,
            properties: %{
              version: :integer,
              timestamp: :string,
              epoch: :integer,
              round: :integer
            },
            additional_properties: false
          )
      },
      required: [:network_identifier, :account_identifier],
      additional_properties: false
    )
  end

  xema :get_stake_positions do
    map(
      keys: :atoms,
      properties: %{
        network_identifier:
          map(
            keys: :atoms,
            properties: %{
              network: {:string, min_length: 1}
            },
            required: [:network],
            additional_properties: false
          ),
        account_identifier:
          map(
            keys: :atoms,
            properties: %{
              address: @address
            },
            required: [:address],
            additional_properties: false
          ),
        at_state_identifier:
          map(
            keys: :atoms,
            properties: %{
              version: :integer,
              timestamp: :string,
              epoch: :integer,
              round: :integer
            },
            additional_properties: false
          )
      },
      required: [:network_identifier, :account_identifier],
      additional_properties: false
    )
  end

  xema :get_unstake_positions do
    map(
      keys: :atoms,
      properties: %{
        network_identifier:
          map(
            keys: :atoms,
            properties: %{
              network: {:string, min_length: 1}
            },
            required: [:network],
            additional_properties: false
          ),
        account_identifier:
          map(
            keys: :atoms,
            properties: %{
              address: @address
            },
            required: [:address],
            additional_properties: false
          ),
        at_state_identifier:
          map(
            keys: :atoms,
            properties: %{
              version: :integer,
              timestamp: :string,
              epoch: :integer,
              round: :integer
            },
            additional_properties: false
          )
      },
      required: [:network_identifier, :account_identifier],
      additional_properties: false
    )
  end

  xema :get_account_transactions do
    map(
      keys: :atoms,
      properties: %{
        network_identifier:
          map(
            keys: :atoms,
            properties: %{
              network: {:string, min_length: 1}
            },
            required: [:network],
            additional_properties: false
          ),
        account_identifier:
          map(
            keys: :atoms,
            properties: %{
              address: @address
            },
            required: [:address],
            additional_properties: false
          ),
        at_state_identifier:
          map(
            keys: :atoms,
            properties: %{
              version: :integer,
              timestamp: :string,
              epoch: :integer,
              round: :integer
            },
            additional_properties: false
          ),
        cursor: {:string, min_length: 1},
        limit: :integer
      },
      required: [:network_identifier, :account_identifier],
      additional_properties: false
    )
  end
end

%{
  network_identifier: %{network: "mainnet"},
  account_identifier: %{
    address: "rdx1qspvw9pupa3qn2uy2x6889wwx6p2n68cjr2gs9t3564s87z9nhpmmcg6tdtrw"
  },
  at_state_identifier: %{version: 9, cat: 9}
}
