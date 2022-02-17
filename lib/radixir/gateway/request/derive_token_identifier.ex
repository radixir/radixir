defmodule Radixir.Gateway.Request.DeriveTokenIdentifier do
  @moduledoc """
  Methods to create each map in `DeriveTokenIdentifier` request body.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()

  @doc """
  Generates stitch plan for `network_identifier` map in `DeriveTokenIdentifier` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `network` (optional, string): If `network` is not in params it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec network_identifier(stitch_plans, params) :: stitch_plans
  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan

  @doc """
  Generates stitch plan for `public_key` map in `DeriveTokenIdentifier` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `hex` (required, integer): Public key hex.
  """
  @spec public_key(stitch_plans, params) :: stitch_plans
  defdelegate public_key(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `symbol` map.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `symbol` (required, string): Symbol.
    - `prefix_keys`: List of atoms that will be prefixed to `keys` list.
  """
  @spec symbol(stitch_plans, params) :: stitch_plans
  defdelegate symbol(stitch_plans, params), to: StitchPlan
end
