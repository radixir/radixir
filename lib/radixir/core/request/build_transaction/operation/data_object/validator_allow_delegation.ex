defmodule Radixir.Core.Request.BuildTransaction.Operation.DataObject.ValidatorAllowDelegation do
  @moduledoc """
  Methods to create each map in `ValidatorAllowDelegation` map.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `type` map in `ValidatorAllowDelegation` map. Value is set to `ValidatorAllowDelegation`.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
  """
  @spec type(stitch_plans) :: stitch_plans
  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "ValidatorAllowDelegation"], [:data, :data_object])
  end

  @doc """
  Generates stitch plan for `allow_delegation` map in `ValidatorAllowDelegation` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `allow_delegation` (required, boolean): Allow delegration.
  """
  @spec allow_delegation(stitch_plans, params) :: stitch_plans
  def allow_delegation(stitch_plans, params) do
    schema = [
      allow_delegation: [
        type: :boolean,
        required: true
      ]
    ]

    allow_delegation =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:allow_delegation)

    stitch_plan = [
      [keys: [:data, :data_object, :allow_delegation], value: allow_delegation]
    ]

    stitch_plan ++ stitch_plans
  end
end
