defmodule Radixir.Gateway.Request.SubmitTransaction do
  @moduledoc """
  Methods to create each map in `SubmitTransaction` request body.
  """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword())
  @type params :: keyword()
  @doc """
  Generates stitch plan for `network_identifier` map in `SubmitTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `network` (optional, string): If `network` is not in params it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec network_identifier(stitch_plans, params) :: stitch_plans
  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan

  @doc """
  Generates stitch plan for `signed_transaction` map in `SubmitTransaction` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `signed_transaction` (required, string): Signed Transaction.
  """
  @spec signed_transaction(stitch_plans, params) :: stitch_plans
  defdelegate signed_transaction(stitch_plans, params), to: StitchPlan
end
