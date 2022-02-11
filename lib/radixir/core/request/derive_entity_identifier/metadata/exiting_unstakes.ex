defmodule Radixir.Core.Request.DeriveEntityIdentifier.Metadata.ExitingUnstakes do
  alias Radixir.StitchPlan

  def type(stitch_plans) do
    StitchPlan.type(stitch_plans, [type: "ExitingUnstakes"], [:metadata])
  end

  def validator(stitch_plans, params) do
    StitchPlan.validator(stitch_plans, params, [:metadata])
  end

  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:metadata, :validator])
  end

  def epoch_unlock(stitch_plans, params) do
    schema = [
      epoch_unlock: [
        type: :integer,
        required: true
      ]
    ]

    epoch_unlock =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:epoch_unlock)

    stitch_plan = [[keys: [:metadata, :epoch_unlock], value: epoch_unlock]]

    stitch_plan ++ stitch_plans
  end
end
