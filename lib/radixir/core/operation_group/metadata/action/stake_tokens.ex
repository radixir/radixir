defmodule Radixir.Core.OperationGroup.Metadata.Action.StakeTokens do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, type: "StakeTokens")
  end

  defdelegate from_account(stitch_plans, params), to: RequestPiece

  def to_validator(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:to_validator, :address], value: address]]

    stitch_plan ++ stitch_plans
  end

  defdelegate to(stitch_plans, params), to: RequestPiece
  defdelegate from(stitch_plans, params), to: RequestPiece

  defdelegate amount(stitch_plans, params), to: RequestPiece

  def token_identifier(stitch_plans, params) do
    RequestPiece.token_identifier(stitch_plans, params, [:amount])
  end
end
