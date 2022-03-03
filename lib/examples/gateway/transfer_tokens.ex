defmodule Examples.Gateway do
  def transfer_tokens() do
    {:ok, %{testnet: %{account_address: account_address}, private_key: private_key}} =
      Radixir.Key.from_mnemonic()

    {:ok, %{testnet: %{account_address: to_address}}} =
      Radixir.Key.from_mnemonic(address_index: 1)

    {:ok, amount} = Radixir.Util.xrd_to_atto("1.0")
    token_rri = Radixir.Config.network_native_token_rri()

    transfer_tokens_params = %{
      from_address: account_address,
      to_address: to_address,
      amount: amount,
      token_rri: token_rri
    }

    options = [headers: ["X-Radixdlt-Target-Gw-Api": "1.0.2"]]

    Radixir.Gateway.transfer_tokens(
      [transfer_tokens_params],
      account_address,
      private_key,
      options
    )
  end
end
