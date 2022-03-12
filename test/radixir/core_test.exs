defmodule Radixir.CoreTest do
  use ExUnit.Case, async: true

  import Mox

  alias Radixir.Core

  setup :verify_on_exit!

  describe "getting username / password / url" do
    test "get_network_configuration - catches not providing auth" do
      assert {:error, "no auth provided"} = Core.get_network_configuration()
    end

    test "get_network_configuration - catches missing password" do
      assert {:error, "no password provided"} =
               Core.get_network_configuration(api: [username: "goku"])
    end

    test "get_network_configuration - catches missing username" do
      assert {:error, "no username provided"} =
               Core.get_network_configuration(api: [password: "hello goku"])
    end

    test "get_network_configuration - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.get_network_configuration(api: [auth_index: 9])
    end

    test "get_network_configuration - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.get_network_configuration(api: [auth_index: 1])
    end

    test "get_network_configuration - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = Core.get_network_configuration(api: [auth_index: 1])
    end

    test "get_network_configuration - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = Core.get_network_configuration(api: [auth_index: 1])
    end

    test "get_network_configuration - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_network_configuration(api: [auth_index: 1])
    end

    test "get_network_configuration - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.get_network_configuration(api: [auth_index: 1])
    end

    test "get_network_configuration - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.get_network_configuration(api: [auth_index: 1])
    end

    test "get_network_configuration - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.get_network_configuration(api: [username: "one", password: "two"])
    end

    test "get_network_configuration - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_network_configuration(api: [username: "hello", password: "dog"])
    end
  end
end
