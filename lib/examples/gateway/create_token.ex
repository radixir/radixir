defmodule Examples.Gateway.CreateToken do
  def go() do
    options = [api: [headers: ["X-Radixdlt-Target-Gw-Api": "1.0.2"]]]

    {:ok,
     %{
       testnet: %{account_address: account_address},
       private_key: private_key,
       public_key: public_key
     }} = Radixir.Key.from_mnemonic()

    symbol = "jec"

    {:ok, %{"token_identifier" => %{"rri" => token_rri}}} =
      Radixir.Gateway.derive_token_identifier(public_key, symbol, options)

    create_token_params = %{
      name: "JEC Token",
      description: "jec tokens ftw",
      icon_url: "https://me.me/icon",
      url: "https://me.me",
      symbol: symbol,
      is_supply_mutable: true,
      granularity: "1",
      owner_address: account_address,
      token_supply: "0",
      token_rri: token_rri,
      to_account_address: account_address
    }

    Radixir.Gateway.create_token(
      [create_token_params],
      account_address,
      private_key,
      options
    )
  end
end
