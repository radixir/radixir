defmodule Radixir.Gateway.Actions do
  def agents() do
    [:create_token, :transfer_tokens, :stake_tokens, :unstake_tokens, :mint_tokens, :burn_tokens]
  end
end
