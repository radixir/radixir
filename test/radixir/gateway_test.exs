defmodule Radixir.GatewayTest do
  use ExUnit.Case, async: true

  import Mox

  alias Radixir.Gateway

  setup :verify_on_exit!

  describe "getting url" do
    test "get_info - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_info()
    end

    test "get_info - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} = Gateway.get_info()
    end
  end
end
