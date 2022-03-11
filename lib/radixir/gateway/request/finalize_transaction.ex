defmodule Radixir.Gateway.Request.FinalizeTransaction do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `FinalizeTransaction` request body.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword)
  @type params :: keyword

  @doc """
  Generates stitch plan for `network_identifier` map in `FinalizeTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `network` (optional, string): If `network` is not in `params` it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec network_identifier(stitch_plans, params) :: stitch_plans
  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan

  @doc """
  Generates stitch plan for `unsigned_transaction` map in `FinalizeTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `unsigned_transaction` (required, string): Unsigned Transaction.
  """
  @spec unsigned_transaction(stitch_plans, params) :: stitch_plans
  defdelegate unsigned_transaction(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `signature` map in `FinalizeTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `bytes` (required, string): Signature bytes.
      - `hex` (required, string): Signature public key hex.
  """
  @spec signature(stitch_plans, params) :: stitch_plans
  defdelegate signature(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `submit` map in `FinalizeTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `submit` (required, boolean): Submit.
  """
  @spec submit(stitch_plans, params) :: stitch_plans
  defdelegate submit(stitch_plans, params), to: StitchPlan
end
