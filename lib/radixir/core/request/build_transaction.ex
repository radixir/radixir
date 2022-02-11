defmodule Radixir.Core.Request.BuildTransaction do
  alias Radixir.StitchPlan
  alias Radixir.Util
  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan

  def add_operation_groups(request, operations_groups) do
    Util.map_put(request, [:operation_groups], operations_groups)
  end

  defdelegate fee_payer(stitch_plans, params \\ []), to: StitchPlan

  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:fee_payer])
  end

  defdelegate message(stitch_plans, params), to: StitchPlan

  def disable_resource_allocate_and_destroy(stitch_plans, params) do
    schema = [
      disable_resource_allocate_and_destroy: [
        type: :boolean,
        required: true
      ]
    ]

    disable_resource_allocate_and_destroy =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:disable_resource_allocate_and_destroy)

    stitch_plan = [
      [
        keys: [:disable_resource_allocate_and_destroy],
        value: disable_resource_allocate_and_destroy
      ]
    ]

    stitch_plan ++ stitch_plans
  end
end
