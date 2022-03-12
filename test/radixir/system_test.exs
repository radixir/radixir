defmodule Radixir.SystemTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  describe "get_version/1" do
    test "successful call to get_version" do
      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "url" == url
        assert "/system/version" == path
        {:ok, %{}}
      end)

      assert {:ok, _} =
               Radixir.System.get_version(url: "url", username: "username", password: "password")
    end

    test "successful call to get_version and getting url from configs" do
      Application.put_env(:radixir, Radixir.Config, system_api_url: "https://me.com")

      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "https://me.com" == url
        assert "/system/version" == path
        {:ok, %{}}
      end)

      assert {:ok, _} = Radixir.System.get_version(username: "username", password: "password")
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = Radixir.System.get_version()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = Radixir.System.get_version(username: "goku")
    end

    test "catches missing username" do
      assert {:error, "no username provided"} = Radixir.System.get_version(password: "hello goku")
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Radixir.System.get_version(auth_index: 9)
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Radixir.System.get_version(auth_index: 1)
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = Radixir.System.get_version(auth_index: 1)
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = Radixir.System.get_version(auth_index: 1)
    end

    test "catches no configuration parameters found" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Radixir.System.get_version(auth_index: 1)
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Radixir.System.get_version(auth_index: 1)
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Radixir.System.get_version(auth_index: 1)
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               Radixir.System.get_version(username: "one", password: "two")
    end
  end

  describe "get_health/1" do
    test "successful call to get_health" do
      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "url" == url
        assert "/system/health" == path
        {:ok, %{}}
      end)

      assert {:ok, _} =
               Radixir.System.get_health(url: "url", username: "username", password: "password")
    end

    test "successful call to get_health and getting url from configs" do
      Application.put_env(:radixir, Radixir.Config, system_api_url: "https://me.com")

      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "https://me.com" == url
        assert "/system/health" == path
        {:ok, %{}}
      end)

      assert {:ok, _} = Radixir.System.get_health(username: "username", password: "password")
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = Radixir.System.get_health()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = Radixir.System.get_health(username: "goku")
    end

    test "catches missing username" do
      assert {:error, "no username provided"} = Radixir.System.get_health(password: "hello goku")
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Radixir.System.get_health(auth_index: 9)
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Radixir.System.get_health(auth_index: 1)
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = Radixir.System.get_health(auth_index: 1)
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = Radixir.System.get_health(auth_index: 1)
    end

    test "catches no configuration parameters found" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Radixir.System.get_health(auth_index: 1)
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Radixir.System.get_health(auth_index: 1)
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Radixir.System.get_health(auth_index: 1)
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               Radixir.System.get_health(username: "one", password: "two")
    end
  end

  describe "get_configuration/1" do
    test "successful call to get_configuration" do
      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "url" == url
        assert "/system/configuration" == path
        {:ok, %{}}
      end)

      assert {:ok, _} =
               Radixir.System.get_configuration(
                 url: "url",
                 username: "username",
                 password: "password"
               )
    end

    test "successful call to get_configuration and getting url from configs" do
      Application.put_env(:radixir, Radixir.Config, system_api_url: "https://me.com")

      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "https://me.com" == url
        assert "/system/configuration" == path
        {:ok, %{}}
      end)

      assert {:ok, _} =
               Radixir.System.get_configuration(username: "username", password: "password")
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = Radixir.System.get_configuration()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = Radixir.System.get_configuration(username: "goku")
    end

    test "catches missing username" do
      assert {:error, "no username provided"} =
               Radixir.System.get_configuration(password: "hello goku")
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Radixir.System.get_configuration(auth_index: 9)
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Radixir.System.get_configuration(auth_index: 1)
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = Radixir.System.get_configuration(auth_index: 1)
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = Radixir.System.get_configuration(auth_index: 1)
    end

    test "catches no configuration parameters found" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Radixir.System.get_configuration(auth_index: 1)
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Radixir.System.get_configuration(auth_index: 1)
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Radixir.System.get_configuration(auth_index: 1)
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               Radixir.System.get_configuration(username: "one", password: "two")
    end
  end

  describe "get_peers/1" do
    test "successful call to get_peers" do
      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "url" == url
        assert "/system/peers" == path
        {:ok, %{}}
      end)

      assert {:ok, _} =
               Radixir.System.get_peers(url: "url", username: "username", password: "password")
    end

    test "successful call to get_peers and getting url from configs" do
      Application.put_env(:radixir, Radixir.Config, system_api_url: "https://me.com")

      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "https://me.com" == url
        assert "/system/peers" == path
        {:ok, %{}}
      end)

      assert {:ok, _} = Radixir.System.get_peers(username: "username", password: "password")
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = Radixir.System.get_peers()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = Radixir.System.get_peers(username: "goku")
    end

    test "catches missing username" do
      assert {:error, "no username provided"} = Radixir.System.get_peers(password: "hello goku")
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Radixir.System.get_peers(auth_index: 9)
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Radixir.System.get_peers(auth_index: 1)
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = Radixir.System.get_peers(auth_index: 1)
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = Radixir.System.get_peers(auth_index: 1)
    end

    test "catches no configuration parameters found" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Radixir.System.get_peers(auth_index: 1)
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Radixir.System.get_peers(auth_index: 1)
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Radixir.System.get_peers(auth_index: 1)
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               Radixir.System.get_peers(username: "one", password: "two")
    end
  end

  describe "get_address_book/1" do
    test "successful call to get_address_book" do
      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "url" == url
        assert "/system/addressbook" == path
        {:ok, %{}}
      end)

      assert {:ok, _} =
               Radixir.System.get_address_book(
                 url: "url",
                 username: "username",
                 password: "password"
               )
    end

    test "successful call to get_address_book and getting url from configs" do
      Application.put_env(:radixir, Radixir.Config, system_api_url: "https://me.com")

      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "https://me.com" == url
        assert "/system/addressbook" == path
        {:ok, %{}}
      end)

      assert {:ok, _} =
               Radixir.System.get_address_book(username: "username", password: "password")
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = Radixir.System.get_address_book()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = Radixir.System.get_address_book(username: "goku")
    end

    test "catches missing username" do
      assert {:error, "no username provided"} =
               Radixir.System.get_address_book(password: "hello goku")
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Radixir.System.get_address_book(auth_index: 9)
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Radixir.System.get_address_book(auth_index: 1)
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = Radixir.System.get_address_book(auth_index: 1)
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = Radixir.System.get_address_book(auth_index: 1)
    end

    test "catches no configuration parameters found" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Radixir.System.get_address_book(auth_index: 1)
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Radixir.System.get_address_book(auth_index: 1)
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Radixir.System.get_address_book(auth_index: 1)
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               Radixir.System.get_address_book(username: "one", password: "two")
    end
  end

  describe "get_metrics/1" do
    test "successful call to get_metrics" do
      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "url" == url
        assert "/system/metrics" == path
        {:ok, %{}}
      end)

      assert {:ok, _} =
               Radixir.System.get_metrics(url: "url", username: "username", password: "password")
    end

    test "successful call to get_metrics and getting url from configs" do
      Application.put_env(:radixir, Radixir.Config, system_api_url: "https://me.com")

      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "https://me.com" == url
        assert "/system/metrics" == path
        {:ok, %{}}
      end)

      assert {:ok, _} = Radixir.System.get_metrics(username: "username", password: "password")
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = Radixir.System.get_metrics()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = Radixir.System.get_metrics(username: "goku")
    end

    test "catches missing username" do
      assert {:error, "no username provided"} = Radixir.System.get_metrics(password: "hello goku")
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Radixir.System.get_metrics(auth_index: 9)
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Radixir.System.get_metrics(auth_index: 1)
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = Radixir.System.get_metrics(auth_index: 1)
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = Radixir.System.get_metrics(auth_index: 1)
    end

    test "catches no configuration parameters found" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Radixir.System.get_metrics(auth_index: 1)
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Radixir.System.get_metrics(auth_index: 1)
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Radixir.System.get_metrics(auth_index: 1)
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               Radixir.System.get_metrics(username: "one", password: "two")
    end
  end

  describe "get_prometheus_metrics/1" do
    test "successful call to get_prometheus_metrics" do
      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "url" == url
        assert "/prometheus/metrics" == path
        {:ok, %{}}
      end)

      assert {:ok, _} =
               Radixir.System.get_prometheus_metrics(
                 url: "url",
                 username: "username",
                 password: "password"
               )
    end

    test "successful call to get_prometheus_metrics and getting url from configs" do
      Application.put_env(:radixir, Radixir.Config, system_api_url: "https://me.com")

      Radixir.MockHTTP
      |> expect(:get, fn url, path, options ->
        assert [auth: {"username", "password"}] == options
        assert "https://me.com" == url
        assert "/prometheus/metrics" == path
        {:ok, %{}}
      end)

      assert {:ok, _} =
               Radixir.System.get_prometheus_metrics(username: "username", password: "password")
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = Radixir.System.get_prometheus_metrics()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} =
               Radixir.System.get_prometheus_metrics(username: "goku")
    end

    test "catches missing username" do
      assert {:error, "no username provided"} =
               Radixir.System.get_prometheus_metrics(password: "hello goku")
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Radixir.System.get_prometheus_metrics(auth_index: 9)
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Radixir.System.get_prometheus_metrics(auth_index: 1)
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = Radixir.System.get_prometheus_metrics(auth_index: 1)
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = Radixir.System.get_prometheus_metrics(auth_index: 1)
    end

    test "catches no configuration parameters found" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Radixir.System.get_prometheus_metrics(auth_index: 1)
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Radixir.System.get_prometheus_metrics(auth_index: 1)
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Radixir.System.get_prometheus_metrics(auth_index: 1)
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               Radixir.System.get_prometheus_metrics(username: "one", password: "two")
    end
  end
end
