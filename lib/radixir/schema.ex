defmodule Radixir.Schema do
  alias Radixir.Config

  def derive_account_identifier do
    network_identifier()
    |> Keyword.merge(public_key())
  end

  def get_account_balances do
    network_identifier()
    |> Keyword.merge(account_identifier())
    |> Keyword.merge(at_state_identifier())
  end

  ##################################################################################################

  defp network_identifier do
    [
      network_identifier: [
        type: :non_empty_keyword_list,
        keys: [
          network: [type: :string, default: Config.network()]
        ]
      ]
    ]
  end

  defp account_identifier do
    [
      account_identifier_address: [
        type: :non_empty_keyword_list,
        required: true,
        keys: [
          address: [required: true, type: :string]
        ]
      ]
    ]
  end

  defp at_state_identifier do
    [
      at_state_identifier: [
        type: :non_empty_keyword_list,
        keys: [
          version: [type: :integer],
          timestamp: [type: :string],
          epoch: [type: :integer],
          round: [type: :integer]
        ]
      ]
    ]
  end

  defp public_key do
    [
      public_key: [
        type: :non_empty_keyword_list,
        required: true,
        keys: [
          hex: [required: true, type: :string]
        ]
      ]
    ]
  end
end
