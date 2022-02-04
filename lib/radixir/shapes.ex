defmodule Radixir.Shapes do
  alias Radixir.Util

  def network_identifier(network) do
    %{network_identifier: %{network: network}}
  end

  def account_identifier(address) do
    %{account_identifier: %{address: address}}
  end

  def validator_identifier(address) do
    %{validator_identifier: %{address: address}}
  end

  def token_identifier(rri) do
    %{token_identifier: %{rri: rri}}
  end

  def transaction_identifier(hash) do
    %{transaction_identifier: %{hash: hash}}
  end

  def state_identifier(state_version, transaction_accumulator) do
    %{
      state_identifier: %{
        state_version: state_version,
        transaction_accumulator: transaction_accumulator
      }
    }
  end

  def sub_entity(address, validator_address, epoch_unlock) do
    %{
      sub_entity: %{
        address: address,
        metadata: %{validator_address: validator_address, epoch_unlock: epoch_unlock}
      }
    }
  end

  def at_state_identifier(nil), do: %{}

  def at_state_identifier(options) do
    version = Keyword.get(:version, options)
    timestamp = Keyword.get(:timestamp, options)
    epoch = Keyword.get(:epoch, options)
    round = Keyword.get(:round, options)

    %{}
    |> Util.maybe_put(:version, version)
    |> Util.maybe_put(:timestamp, timestamp)
    |> Util.maybe_put(:epoch, epoch)
    |> Util.maybe_put(:round, round)
  end

  def public_key(public_key_hex) do
    %{public_key: %{hex: public_key_hex}}
  end

  def fee_payer(address) do
    %{fee_payer: %{address: address}}
  end

  def signature(public_key_hex, bytes) do
    public_key(public_key_hex)
    |> Map.put(:bytes, bytes)
  end
end
