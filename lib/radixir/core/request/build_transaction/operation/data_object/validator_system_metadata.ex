defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.ValidatorSystemMetadata do
  @moduledoc """
  Methods to create each map in `ValidatorSystemMetadata` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `ValidatorSystemMetadata` map. Value is set to `ValidatorSystemMetadata`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "ValidatorSystemMetadata"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `date` map in `ValidatorSystemMetadata` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `date` (required, string): Date.
  """
  @spec date(stitch_plans, params) :: stitch_plans
  def date(stitch_plans, params) do
    schema = [
      date: [
        type: :string,
        required: true
      ]
    ]

    date =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:date)

    stitch_plan = [[keys: [:data, :data_object, :date], value: date]]

    stitch_plan ++ stitch_plans
  end
end
