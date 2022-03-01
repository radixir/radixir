defmodule Radixir.Core.Request.GetEntityInformation do
  @moduledoc """
  Methods to create each map in `GetEntityInformation` request body.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `network_identifier` map in `GetEntityInformation` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `network` (optional, string): If `network` is not in `params` it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec network_identifier(stitch_plans, params) :: stitch_plans
  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan

  @doc """
  Generates stitch plan for `entity_identifier` map in `GetEntityInformation` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec entity_identifier(stitch_plans, params) :: stitch_plans
  defdelegate entity_identifier(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `sub_entity` map in `GetEntityInformation` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Sub Entity address.
      - `validator_address` (optional, string): Validator address.
      - `epoch_unlock` (optional, integer): Epoch unlock.
  """
  @spec sub_entity(stitch_plans, params) :: stitch_plans
  def sub_entity(stitch_plans, params) do
    StitchPlan.sub_entity(stitch_plans, params, [:entity_identifer])
  end
end
