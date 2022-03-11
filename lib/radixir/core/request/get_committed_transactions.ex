defmodule Radixir.Core.Request.GetCommittedTransactions do
  @moduledoc false
  # @moduledoc """
  # Methods to create each map in `GetCommittedTransactions` request body.
  # """
  alias Radixir.StitchPlan

  @type stitch_plans :: list(keyword)
  @type params :: keyword

  @doc """
  Generates stitch plan for `network_identifier` map in `GetCommittedTransactions` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `network` (optional, string): If `network` is not in `params` it will default to what is returned from `Radixir.Config.network()`.
  """
  @spec network_identifier(stitch_plans, params) :: stitch_plans
  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan

  @doc """
  Generates stitch plan for `state_identifier` map in `GetCommittedTransactions` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `state_version` (required, integer): State Version.
      - `transaction_accumulator` (optional, string): Transaction Accumulator.
  """
  @spec state_identifier(stitch_plans, params) :: stitch_plans
  defdelegate state_identifier(stitch_plans, params), to: StitchPlan

  @doc """
  Generates stitch plan for `limit` map in `GetCommittedTransactions` request body.

  ## Parameters
    - `stitch_plans`: On-going stitch plans that will be stitched into a map.
    - `params`: Keyword list that contains:
      - `limit` (required, integer): Limit.
  """
  @spec limit(stitch_plans, params) :: stitch_plans
  defdelegate limit(stitch_plans, params), to: StitchPlan
end
