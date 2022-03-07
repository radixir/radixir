defmodule Examples.Core.TransferTokens do
  def go do
    {:ok, %{testnet: %{account_address: account_address}, private_key: private_key}} =
      Radixir.Key.from_mnemonic()

    {:ok, %{testnet: %{account_address: to_address}}} =
      Radixir.Key.from_mnemonic(address_index: 1)

    amount_positive = Radixir.Util.xrd_to_atto("1.0")
    amount_negative = Radixir.Util.xrd_negate(amount_positive)

    token_rri = Radixir.Config.network_native_token_rri()

    operation_type = "Resource"

    options = [api: [auth_index: 0]]

    type = Radixir.Core.build_operation_type(operation_type)
    entity_identifier_from = Radixir.Core.build_operation_entity_identifier(account_address)
    entity_identifier_to = Radixir.Core.build_operation_entity_identifier(to_address)

    amount_from = Radixir.Core.build_operation_amount_token(amount_negative, token_rri)
    amount_to = Radixir.Core.build_operation_amount_token(amount_positive, token_rri)

    operation_from =
      Radixir.Core.build_operation(type, entity_identifier_from, amount: amount_from)

    operation_to = Radixir.Core.build_operation(type, entity_identifier_to, amount: amount_to)

    operation_group = Radixir.Core.build_operation_group([operation_from, operation_to])

    Radixir.Core.send_transaction([operation_group], account_address, private_key, options)
  end
end
