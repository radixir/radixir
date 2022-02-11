defmodule Radixir.Gateway.Request.BuildTransaction do
  alias Radixir.StitchPlan
  alias Radixir.Util

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
  defdelegate at_state_identifier(stitch_plans, params), to: StitchPlan

  def add_actions(request, actions) do
    Util.map_put(request, [:actions], actions)
  end

  defdelegate fee_payer(stitch_plans, params), to: StitchPlan
  defdelegate message(stitch_plans, params), to: StitchPlan

  defdelegate disable_token_mint_and_burn(stitch_plans, params), to: StitchPlan
end
