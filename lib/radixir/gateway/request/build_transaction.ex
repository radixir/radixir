defmodule Radixir.Gateway.Request.BuildTransaction do
  alias Radixir.RequestPiece
  alias Radixir.Util

  defdelegate network_identifier(stitch_plans, params \\ []), to: RequestPiece
  defdelegate at_state_identifier(stitch_plans, params), to: RequestPiece

  def add_actions(request, actions) do
    Util.map_put(request, [:actions], actions)
  end

  defdelegate fee_payer(stitch_plans, params), to: RequestPiece
  defdelegate message(stitch_plans, params), to: RequestPiece

  defdelegate disable_token_mint_and_burn(stitch_plans, params), to: RequestPiece
end
