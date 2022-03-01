defmodule Radixir.Gateway.Request.BuildTransaction do
  @moduledoc """
  Methods to create each map in `BuildTransaction` request body.
  """
  alias Radixir.StitchPlan
  alias Radixir.Util

  @type stitch_plans :: list(keyword())
  @type params :: keyword()
  @type request :: map()
  @type actions :: list(map())

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
  Generates stitch plan for `at_state_identifier` map in `BuildTransaction` request body.

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

  @doc """
  Adds `actions` to `BuildTransaction` request body.

  ## Parameters
    - `request`: Request body.
    - `actions`: List of action maps to be added to request body.
  """
  @spec add_actions(request, actions) :: map()
  def add_actions(request, actions) do
    Util.map_put(request, [:actions], actions)
  end

  @doc """
  Generates stitch plan for `fee_payer` map in `BuildTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `address` (required, string): Radix address.
  """
  @spec fee_payer(stitch_plans, params) :: stitch_plans
  defdelegate fee_payer(stitch_plans, params), to: StitchPlan

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
  Generates stitch plan for `disable_token_mint_and_burn` map in `BuildTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `disable_token_mint_and_burn` (required, boolean): Disable Token Mint and Burn.
  """
  @spec disable_token_mint_and_burn(stitch_plans, params) :: stitch_plans
  defdelegate disable_token_mint_and_burn(stitch_plans, params), to: StitchPlan
end
