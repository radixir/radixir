defmodule Radixir.Gateway.Request.GetNativeTokenInfo do
  @moduledoc """
  Methods to create each map in `GetNativeTokenInfo` request body.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `network_identifier` map in `GetNativeTokenInfo` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `network` (optional, string): If `network` is not in `params` it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec network_identifier(stitch_plans, params) :: stitch_plans
  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan

  @doc """
  Generates stitch plan for `at_state_identifier` map in `GetNativeTokenInfo` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `version` (optional, integer): Version.
      - `timestamp` (optional, string): Timestamp.
      - `epoch` (optional, integer): Epoch.
      - `round` (optional, integer): Round.
  """
  @spec at_state_identifier(stitch_plans, params) :: stitch_plans
  defdelegate at_state_identifier(stitch_plans, params), to: StitchPlan
end
