defmodule Radixir.Core.Request.SignTransaction do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `SignTransaction` request body.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword)
  @type params :: keyword

  @doc """
  Generates stitch plan for `network_identifier` map in `SignTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `network` (optional, string): If `network` is not in `params` it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec network_identifier(stitch_plans, params) :: stitch_plans
  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan

  @doc """
  Generates stitch plan for `unsigned_transaction` map in `SignTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `unsigned_transaction` (required, string): Unsigned Transaction.
  """
  @spec unsigned_transaction(stitch_plans, params) :: stitch_plans
  defdelegate unsigned_transaction(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `public_key` map in `SignTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `hex` (required, integer): Public key hex.
  """
  @spec public_key(stitch_plans, params) :: stitch_plans
  defdelegate public_key(stitch_plans, params), to: StitchPlan
end
