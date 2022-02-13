defmodule Radixir.Gateway.Request.DeriveAccountIdentifier do
  alias Radixir.StitchPlan
  alias Radixir.Schema.Gateway
  alias Radixir.Util

  defdelegate network_identifier(stitch_plans, params \\ []), to: StitchPlan
  defdelegate public_key(stitch_plans, params), to: StitchPlan

  def build(stitch_plans) do
    build = Util.stitch(stitch_plans)

    case Gateway.validate(:derive_account_identifier, build) do
      :ok ->
        {:ok, build}

      {:error, %Xema.ValidationError{} = error} ->
        {:error, Exception.message(error), error}
    end
  end
end
