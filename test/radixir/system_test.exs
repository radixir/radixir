defmodule Radixir.SystemTest do
  use ExUnit.Case, async: true

  import Mox

  alias Radixir.System

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
               System.get_version(api: [url: "url", username: "username", password: "password"])
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

      assert {:ok, _} = System.get_version(api: [username: "username", password: "password"])
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = System.get_version()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = System.get_version(api: [username: "goku"])
    end

    test "catches missing username" do
      assert {:error, "no username provided"} = System.get_version(api: [password: "hello goku"])
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               System.get_version(api: [auth_index: 9])
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               System.get_version(api: [auth_index: 1])
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = System.get_version(api: [auth_index: 1])
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = System.get_version(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_version(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_version(api: [username: "doug", password: "cat"])
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               System.get_version(api: [auth_index: 1])
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               System.get_version(api: [auth_index: 1])
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               System.get_version(api: [username: "one", password: "two"])
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
               System.get_health(api: [url: "url", username: "username", password: "password"])
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

      assert {:ok, _} = System.get_health(api: [username: "username", password: "password"])
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = System.get_health()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = System.get_health(api: [username: "goku"])
    end

    test "catches missing username" do
      assert {:error, "no username provided"} = System.get_health(api: [password: "hello goku"])
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               System.get_health(api: [auth_index: 9])
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               System.get_health(api: [auth_index: 1])
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = System.get_health(api: [auth_index: 1])
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = System.get_health(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_health(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_health(api: [username: "doug", password: "cat"])
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               System.get_health(api: [auth_index: 1])
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               System.get_health(api: [auth_index: 1])
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               System.get_health(api: [username: "one", password: "two"])
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
               System.get_configuration(
                 api: [url: "url", username: "username", password: "password"]
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
               System.get_configuration(api: [username: "username", password: "password"])
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = System.get_configuration()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = System.get_configuration(api: [username: "goku"])
    end

    test "catches missing username" do
      assert {:error, "no username provided"} =
               System.get_configuration(api: [password: "hello goku"])
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               System.get_configuration(api: [auth_index: 9])
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               System.get_configuration(api: [auth_index: 1])
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = System.get_configuration(api: [auth_index: 1])
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = System.get_configuration(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_configuration(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_configuration(api: [username: "doug", password: "cat"])
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               System.get_configuration(api: [auth_index: 1])
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               System.get_configuration(api: [auth_index: 1])
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               System.get_configuration(api: [username: "one", password: "two"])
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
               System.get_peers(api: [url: "url", username: "username", password: "password"])
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

      assert {:ok, _} = System.get_peers(api: [username: "username", password: "password"])
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = System.get_peers()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = System.get_peers(api: [username: "goku"])
    end

    test "catches missing username" do
      assert {:error, "no username provided"} = System.get_peers(api: [password: "hello goku"])
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               System.get_peers(api: [auth_index: 9])
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               System.get_peers(api: [auth_index: 1])
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = System.get_peers(api: [auth_index: 1])
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = System.get_peers(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_peers(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_peers(api: [username: "doug", password: "cat"])
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               System.get_peers(api: [auth_index: 1])
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               System.get_peers(api: [auth_index: 1])
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               System.get_peers(api: [username: "one", password: "two"])
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
               System.get_address_book(
                 api: [url: "url", username: "username", password: "password"]
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

      assert {:ok, _} = System.get_address_book(api: [username: "username", password: "password"])
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = System.get_address_book()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = System.get_address_book(api: [username: "goku"])
    end

    test "catches missing username" do
      assert {:error, "no username provided"} =
               System.get_address_book(api: [password: "hello goku"])
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               System.get_address_book(api: [auth_index: 9])
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               System.get_address_book(api: [auth_index: 1])
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = System.get_address_book(api: [auth_index: 1])
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = System.get_address_book(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_address_book(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_address_book(api: [username: "doug", password: "cat"])
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               System.get_address_book(api: [auth_index: 1])
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               System.get_address_book(api: [auth_index: 1])
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               System.get_address_book(api: [username: "one", password: "two"])
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
               System.get_metrics(api: [url: "url", username: "username", password: "password"])
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

      assert {:ok, _} = System.get_metrics(api: [username: "username", password: "password"])
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = System.get_metrics()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} = System.get_metrics(api: [username: "goku"])
    end

    test "catches missing username" do
      assert {:error, "no username provided"} = System.get_metrics(api: [password: "hello goku"])
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               System.get_metrics(api: [auth_index: 9])
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               System.get_metrics(api: [auth_index: 1])
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = System.get_metrics(api: [auth_index: 1])
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = System.get_metrics(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_metrics(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_metrics(api: [username: "doug", password: "cat"])
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               System.get_metrics(api: [auth_index: 1])
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               System.get_metrics(api: [auth_index: 1])
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               System.get_metrics(api: [username: "one", password: "two"])
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
               System.get_prometheus_metrics(
                 api: [url: "url", username: "username", password: "password"]
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
               System.get_prometheus_metrics(api: [username: "username", password: "password"])
    end

    test "catches not providing auth" do
      assert {:error, "no auth provided"} = System.get_prometheus_metrics()
    end

    test "catches missing password" do
      assert {:error, "no password provided"} =
               System.get_prometheus_metrics(api: [username: "goku"])
    end

    test "catches missing username" do
      assert {:error, "no username provided"} =
               System.get_prometheus_metrics(api: [password: "hello goku"])
    end

    test "catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               System.get_prometheus_metrics(api: [auth_index: 9])
    end

    test "catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               System.get_prometheus_metrics(api: [auth_index: 1])
    end

    test "catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = System.get_prometheus_metrics(api: [auth_index: 1])
    end

    test "catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = System.get_prometheus_metrics(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_prometheus_metrics(api: [auth_index: 1])
    end

    test "catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               System.get_prometheus_metrics(api: [username: "doug", password: "cat"])
    end

    test "catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               System.get_prometheus_metrics(api: [auth_index: 1])
    end

    test "catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               System.get_prometheus_metrics(api: [auth_index: 1])
    end

    test "catches system_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "system_api_url not found in configuration"} =
               System.get_prometheus_metrics(api: [username: "one", password: "two"])
    end
  end
end
