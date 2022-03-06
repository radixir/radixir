defmodule Radixir.Core.Request.BuildTransaction do
  @moduledoc """
  Methods to create each map in `BuildTransaction` request body.
  """
  alias Radixir.StitchPlan
  alias Radixir.Util

  @type stitch_plans :: list(keyword())
  @type params :: keyword()
  @type request :: map
  @type operations_groups :: list(map)

  @doc """
  Generates stitch plan for `network_identifier` map in `BuildTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `network` (optional, string): If `network` is not in `params` it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec network_identifier(stitch_plans, params) :: stitch_plans
  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan

  @doc """
  Adds `operation_groups` to `BuildTransaction` request body.

  ## Parameters
    - `request`: Request body.
    - `operation_groups`: List of operation maps to be added to request body.
  """
  @spec add_operation_groups(request, operations_groups) :: map
  def add_operation_groups(request, operations_groups) do
    Util.map_put(request, [:operation_groups], operations_groups)
  end

  @doc """
  Generates stitch plan for `fee_payer` map in `BuildTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec fee_payer(stitch_plans, params) :: stitch_plans
  defdelegate fee_payer(stitch_plans, params \\ []), to: StitchPlan

  @doc """
  Generates stitch plan for `sub_entity` map in `BuildTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `sub_entity_address` (required, string): Sub Entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
  """
  @spec sub_entity(stitch_plans, params) :: stitch_plans
  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:fee_payer])
  end

  @doc """
  Generates stitch plan for `message` map in `BuildTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `message` (required, string): Message.
  """
  @spec message(stitch_plans, params) :: stitch_plans
  defdelegate message(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `disable_resource_allocate_and_destroy` map in `BuildTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `disable_resource_allocate_and_destroy` (required, boolean): Disable resource allocate and destroy.
  """
  @spec disable_resource_allocate_and_destroy(stitch_plans, params) :: stitch_plans
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
