defmodule Radixir.Core.OperationGroup.Metadata.Action.UnstakeTokens do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, type: "UntakeTokens")
  end

  def from_validator(stitch_plans, params) do
    schema = [
      address: [
        type: :string,
        required: true
      ]
    ]

    address =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:address)

    stitch_plan = [[keys: [:from_validator, :address], value: address]]

    stitch_plan ++ stitch_plans
  end

  defdelegate to_account(stitch_plans, params), to: RequestPiece
  defdelegate to(stitch_plans, params), to: RequestPiece
  defdelegate from(stitch_plans, params), to: RequestPiece

  defdelegate amount(stitch_plans, params), to: RequestPiece

  def token_identifier(stitch_plans, params) do
    RequestPiece.token_identifier(stitch_plans, params, [:amount])
  end

  def unstake_percentage(stitch_plans, params) do
    schema = [
      unstake_percentage: [
        type: :non_neg_integer,
        required: true
      ]
    ]

    unstake_percentage =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:unstake_percentage)

    stitch_plan = [[keys: [:unstake_percentage], value: unstake_percentage]]

    stitch_plan ++ stitch_plans
  end
end
