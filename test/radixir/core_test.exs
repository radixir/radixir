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

    test "get_network_status - catches not providing auth" do
      assert {:error, "no auth provided"} = Core.get_network_status()
    end

    test "get_network_status - catches missing password" do
      assert {:error, "no password provided"} = Core.get_network_status(api: [username: "goku"])
    end

    test "get_network_status - catches missing username" do
      assert {:error, "no username provided"} =
               Core.get_network_status(api: [password: "hello goku"])
    end

    test "get_network_status - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.get_network_status(api: [auth_index: 9])
    end

    test "get_network_status - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.get_network_status(api: [auth_index: 1])
    end

    test "get_network_status - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = Core.get_network_status(api: [auth_index: 1])
    end

    test "get_network_status - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = Core.get_network_status(api: [auth_index: 1])
    end

    test "get_network_status - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_network_status(api: [auth_index: 1])
    end

    test "get_network_status - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.get_network_status(api: [auth_index: 1])
    end

    test "get_network_status - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.get_network_status(api: [auth_index: 1])
    end

    test "get_network_status - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.get_network_status(api: [username: "one", password: "two"])
    end

    test "get_network_status - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_network_status(api: [username: "hello", password: "dog"])
    end

    test "get_entity_information - catches not providing auth" do
      assert {:error, "no auth provided"} = Core.get_entity_information("address here")
    end

    test "get_entity_information - catches missing password" do
      assert {:error, "no password provided"} =
               Core.get_entity_information("address here", api: [username: "goku"])
    end

    test "get_entity_information - catches missing username" do
      assert {:error, "no username provided"} =
               Core.get_entity_information("address here", api: [password: "hello goku"])
    end

    test "get_entity_information - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.get_entity_information("address here", api: [auth_index: 9])
    end

    test "get_entity_information - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.get_entity_information("address here", api: [auth_index: 1])
    end

    test "get_entity_information - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.get_entity_information("address here", api: [auth_index: 1])
    end

    test "get_entity_information - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.get_entity_information("address here", api: [auth_index: 1])
    end

    test "get_entity_information - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_entity_information("address here", api: [auth_index: 1])
    end

    test "get_entity_information - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.get_entity_information("address here", api: [auth_index: 1])
    end

    test "get_entity_information - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.get_entity_information("address here", api: [auth_index: 1])
    end

    test "get_entity_information - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.get_entity_information("address here", api: [username: "one", password: "two"])
    end

    test "get_entity_information - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_entity_information("address here",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "get_mempool_transactions - catches not providing auth" do
      assert {:error, "no auth provided"} = Core.get_mempool_transactions()
    end

    test "get_mempool_transactions - catches missing password" do
      assert {:error, "no password provided"} =
               Core.get_mempool_transactions(api: [username: "goku"])
    end

    test "get_mempool_transactions - catches missing username" do
      assert {:error, "no username provided"} =
               Core.get_mempool_transactions(api: [password: "hello goku"])
    end

    test "get_mempool_transactions - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.get_mempool_transactions(api: [auth_index: 9])
    end

    test "get_mempool_transactions - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.get_mempool_transactions(api: [auth_index: 1])
    end

    test "get_mempool_transactions - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = Core.get_mempool_transactions(api: [auth_index: 1])
    end

    test "get_mempool_transactions - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = Core.get_mempool_transactions(api: [auth_index: 1])
    end

    test "get_mempool_transactions - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_mempool_transactions(api: [auth_index: 1])
    end

    test "get_mempool_transactions - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.get_mempool_transactions(api: [auth_index: 1])
    end

    test "get_mempool_transactions - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.get_mempool_transactions(api: [auth_index: 1])
    end

    test "get_mempool_transactions - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.get_mempool_transactions(api: [username: "one", password: "two"])
    end

    test "get_mempool_transactions - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_mempool_transactions(api: [username: "hello", password: "dog"])
    end

    test "get_mempool_transaction - catches not providing auth" do
      assert {:error, "no auth provided"} = Core.get_mempool_transaction("transaction hash here")
    end

    test "get_mempool_transaction - catches missing password" do
      assert {:error, "no password provided"} =
               Core.get_mempool_transaction("transaction hash here", api: [username: "goku"])
    end

    test "get_mempool_transaction - catches missing username" do
      assert {:error, "no username provided"} =
               Core.get_mempool_transaction("transaction hash here", api: [password: "hello goku"])
    end

    test "get_mempool_transaction - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.get_mempool_transaction("transaction hash here", api: [auth_index: 9])
    end

    test "get_mempool_transaction - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.get_mempool_transaction("transaction hash here", api: [auth_index: 1])
    end

    test "get_mempool_transaction - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.get_mempool_transaction("transaction hash here", api: [auth_index: 1])
    end

    test "get_mempool_transaction - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.get_mempool_transaction("transaction hash here", api: [auth_index: 1])
    end

    test "get_mempool_transaction - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_mempool_transaction("transaction hash here", api: [auth_index: 1])
    end

    test "get_mempool_transaction - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.get_mempool_transaction("transaction hash here", api: [auth_index: 1])
    end

    test "get_mempool_transaction - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.get_mempool_transaction("transaction hash here", api: [auth_index: 1])
    end

    test "get_mempool_transaction - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.get_mempool_transaction("transaction hash here",
                 api: [username: "one", password: "two"]
               )
    end

    test "get_mempool_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_mempool_transaction("transaction hash here",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "get_committed_transactions - catches not providing auth" do
      assert {:error, "no auth provided"} = Core.get_committed_transactions(9000)
    end

    test "get_committed_transactions - catches missing password" do
      assert {:error, "no password provided"} =
               Core.get_committed_transactions(9000, api: [username: "goku"])
    end

    test "get_committed_transactions - catches missing username" do
      assert {:error, "no username provided"} =
               Core.get_committed_transactions(9000, api: [password: "hello goku"])
    end

    test "get_committed_transactions - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.get_committed_transactions(9000, api: [auth_index: 9])
    end

    test "get_committed_transactions - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.get_committed_transactions(9000, api: [auth_index: 1])
    end

    test "get_committed_transactions - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.get_committed_transactions(9000, api: [auth_index: 1])
    end

    test "get_committed_transactions - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.get_committed_transactions(9000, api: [auth_index: 1])
    end

    test "get_committed_transactions - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_committed_transactions(9000, api: [auth_index: 1])
    end

    test "get_committed_transactions - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.get_committed_transactions(9000, api: [auth_index: 1])
    end

    test "get_committed_transactions - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.get_committed_transactions(9000, api: [auth_index: 1])
    end

    test "get_committed_transactions - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.get_committed_transactions(9000,
                 api: [username: "one", password: "two"]
               )
    end

    test "get_committed_transactions - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_committed_transactions(9000,
                 api: [username: "hello", password: "dog"]
               )
    end

    test "derive_account_entity_identifier - catches not providing auth" do
      assert {:error, "no auth provided"} =
               Core.derive_account_entity_identifier("public key here")
    end

    test "derive_account_entity_identifier - catches missing password" do
      assert {:error, "no password provided"} =
               Core.derive_account_entity_identifier("public key here", api: [username: "goku"])
    end

    test "derive_account_entity_identifier - catches missing username" do
      assert {:error, "no username provided"} =
               Core.derive_account_entity_identifier("public key here",
                 api: [password: "hello goku"]
               )
    end

    test "derive_account_entity_identifier - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.derive_account_entity_identifier("public key here", api: [auth_index: 9])
    end

    test "derive_account_entity_identifier - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.derive_account_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_account_entity_identifier - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.derive_account_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_account_entity_identifier - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.derive_account_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_account_entity_identifier - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_account_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_account_entity_identifier - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.derive_account_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_account_entity_identifier - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.derive_account_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_account_entity_identifier - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.derive_account_entity_identifier("public key here",
                 api: [username: "one", password: "two"]
               )
    end

    test "derive_account_entity_identifier - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_account_entity_identifier("public key here",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "derive_validator_entity_identifier - catches not providing auth" do
      assert {:error, "no auth provided"} =
               Core.derive_validator_entity_identifier("public key here")
    end

    test "derive_validator_entity_identifier - catches missing password" do
      assert {:error, "no password provided"} =
               Core.derive_validator_entity_identifier("public key here", api: [username: "goku"])
    end

    test "derive_validator_entity_identifier - catches missing username" do
      assert {:error, "no username provided"} =
               Core.derive_validator_entity_identifier("public key here",
                 api: [password: "hello goku"]
               )
    end

    test "derive_validator_entity_identifier - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.derive_validator_entity_identifier("public key here", api: [auth_index: 9])
    end

    test "derive_validator_entity_identifier - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.derive_validator_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_validator_entity_identifier - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.derive_validator_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_validator_entity_identifier - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.derive_validator_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_validator_entity_identifier - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_validator_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_validator_entity_identifier - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.derive_validator_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_validator_entity_identifier - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.derive_validator_entity_identifier("public key here", api: [auth_index: 1])
    end

    test "derive_validator_entity_identifier - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.derive_validator_entity_identifier("public key here",
                 api: [username: "one", password: "two"]
               )
    end

    test "derive_validator_entity_identifier - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_validator_entity_identifier("public key here",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "derive_token_entity_identifier - catches not providing auth" do
      assert {:error, "no auth provided"} =
               Core.derive_token_entity_identifier("public key here", "symbol here")
    end

    test "derive_token_entity_identifier - catches missing password" do
      assert {:error, "no password provided"} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [username: "goku"]
               )
    end

    test "derive_token_entity_identifier - catches missing username" do
      assert {:error, "no username provided"} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [password: "hello goku"]
               )
    end

    test "derive_token_entity_identifier - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [auth_index: 9]
               )
    end

    test "derive_token_entity_identifier - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [auth_index: 1]
               )
    end

    test "derive_token_entity_identifier - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [auth_index: 1]
               )
    end

    test "derive_token_entity_identifier - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [auth_index: 1]
               )
    end

    test "derive_token_entity_identifier - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [auth_index: 1]
               )
    end

    test "derive_token_entity_identifier - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [auth_index: 1]
               )
    end

    test "derive_token_entity_identifier - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [auth_index: 1]
               )
    end

    test "derive_token_entity_identifier - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [username: "one", password: "two"]
               )
    end

    test "derive_token_entity_identifier - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches not providing auth" do
      assert {:error, "no auth provided"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here"
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches missing password" do
      assert {:error, "no password provided"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [username: "goku"]
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches missing username" do
      assert {:error, "no username provided"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [password: "hello goku"]
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [auth_index: 9]
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [username: "one", password: "two"]
               )
    end

    test "derive_prepared_stakes_entity_identifier - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "derive_prepared_unstakes_entity_identifier - catches not providing auth" do
      assert {:error, "no auth provided"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here")
    end

    test "derive_prepared_unstakes_entity_identifier - catches missing password" do
      assert {:error, "no password provided"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [username: "goku"]
               )
    end

    test "derive_prepared_unstakes_entity_identifier - catches missing username" do
      assert {:error, "no username provided"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [password: "hello goku"]
               )
    end

    test "derive_prepared_unstakes_entity_identifier - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [auth_index: 9]
               )
    end

    test "derive_prepared_unstakes_entity_identifier - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_unstakes_entity_identifier - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_unstakes_entity_identifier - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_unstakes_entity_identifier - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_unstakes_entity_identifier - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_unstakes_entity_identifier - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_prepared_unstakes_entity_identifier - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [username: "one", password: "two"]
               )
    end

    test "derive_prepared_unstakes_entity_identifier - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches not providing auth" do
      assert {:error, "no auth provided"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches missing password" do
      assert {:error, "no password provided"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000,
                 api: [username: "goku"]
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches missing username" do
      assert {:error, "no username provided"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000,
                 api: [password: "hello goku"]
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000,
                 api: [auth_index: 9]
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000,
                 api: [auth_index: 1]
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000,
                 api: [auth_index: 1]
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000,
                 api: [auth_index: 1]
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000,
                 api: [auth_index: 1]
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000,
                 api: [auth_index: 1]
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000,
                 api: [auth_index: 1]
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000,
                 api: [username: "one", password: "two"]
               )
    end

    test "derive_exiting_unstakes_entity_identifier - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 1000,
                 api: [username: "hello", password: "dog"]
               )
    end

    test "derive_validator_system_entity_identifier - catches not providing auth" do
      assert {:error, "no auth provided"} =
               Core.derive_validator_system_entity_identifier("public key here")
    end

    test "derive_validator_system_entity_identifier - catches missing password" do
      assert {:error, "no password provided"} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [username: "goku"]
               )
    end

    test "derive_validator_system_entity_identifier - catches missing username" do
      assert {:error, "no username provided"} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [password: "hello goku"]
               )
    end

    test "derive_validator_system_entity_identifier - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [auth_index: 9]
               )
    end

    test "derive_validator_system_entity_identifier - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_validator_system_entity_identifier - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_validator_system_entity_identifier - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_validator_system_entity_identifier - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_validator_system_entity_identifier - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_validator_system_entity_identifier - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [auth_index: 1]
               )
    end

    test "derive_validator_system_entity_identifier - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [username: "one", password: "two"]
               )
    end

    test "derive_validator_system_entity_identifier - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "build_transaction - catches not providing auth" do
      assert {:error, "no auth provided"} = Core.build_transaction([], "fee payer adddress")
    end

    test "build_transaction - catches missing password" do
      assert {:error, "no password provided"} =
               Core.build_transaction([], "fee payer adddress", api: [username: "goku"])
    end

    test "build_transaction - catches missing username" do
      assert {:error, "no username provided"} =
               Core.build_transaction([], "fee payer adddress", api: [password: "hello goku"])
    end

    test "build_transaction - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.build_transaction([], "fee payer adddress", api: [auth_index: 9])
    end

    test "build_transaction - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.build_transaction([], "fee payer adddress", api: [auth_index: 1])
    end

    test "build_transaction - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.build_transaction([], "fee payer adddress", api: [auth_index: 1])
    end

    test "build_transaction - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.build_transaction([], "fee payer adddress", api: [auth_index: 1])
    end

    test "build_transaction - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.build_transaction([], "fee payer adddress", api: [auth_index: 1])
    end

    test "build_transaction - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.build_transaction([], "fee payer adddress", api: [auth_index: 1])
    end

    test "build_transaction - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.build_transaction([], "fee payer adddress", api: [auth_index: 1])
    end

    test "build_transaction - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.build_transaction([], "fee payer adddress",
                 api: [username: "one", password: "two"]
               )
    end

    test "build_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.build_transaction([], "fee payer adddress",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "parse_transaction - catches not providing auth" do
      assert {:error, "no auth provided"} = Core.parse_transaction("transaction", true)
    end

    test "parse_transaction - catches missing password" do
      assert {:error, "no password provided"} =
               Core.parse_transaction("transaction", true, api: [username: "goku"])
    end

    test "parse_transaction - catches missing username" do
      assert {:error, "no username provided"} =
               Core.parse_transaction("transaction", true, api: [password: "hello goku"])
    end

    test "parse_transaction - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.parse_transaction("transaction", true, api: [auth_index: 9])
    end

    test "parse_transaction - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.parse_transaction("transaction", true, api: [auth_index: 1])
    end

    test "parse_transaction - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.parse_transaction("transaction", true, api: [auth_index: 1])
    end

    test "parse_transaction - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.parse_transaction("transaction", true, api: [auth_index: 1])
    end

    test "parse_transaction - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.parse_transaction("transaction", true, api: [auth_index: 1])
    end

    test "parse_transaction - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.parse_transaction("transaction", true, api: [auth_index: 1])
    end

    test "parse_transaction - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.parse_transaction("transaction", true, api: [auth_index: 1])
    end

    test "parse_transaction - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.parse_transaction("transaction", true, api: [username: "one", password: "two"])
    end

    test "parse_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.parse_transaction("transaction", true,
                 api: [username: "hello", password: "dog"]
               )
    end

    test "finalize_transaction - catches not providing auth" do
      assert {:error, "no auth provided"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes"
               )
    end

    test "finalize_transaction - catches missing password" do
      assert {:error, "no password provided"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes",
                 api: [username: "goku"]
               )
    end

    test "finalize_transaction - catches missing username" do
      assert {:error, "no username provided"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes",
                 api: [password: "hello goku"]
               )
    end

    test "finalize_transaction - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes",
                 api: [auth_index: 9]
               )
    end

    test "finalize_transaction - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes",
                 api: [auth_index: 1]
               )
    end

    test "finalize_transaction - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes",
                 api: [auth_index: 1]
               )
    end

    test "finalize_transaction - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes",
                 api: [auth_index: 1]
               )
    end

    test "finalize_transaction - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes",
                 api: [auth_index: 1]
               )
    end

    test "finalize_transaction - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes",
                 api: [auth_index: 1]
               )
    end

    test "finalize_transaction - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes",
                 api: [auth_index: 1]
               )
    end

    test "finalize_transaction - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes",
                 api: [username: "one", password: "two"]
               )
    end

    test "finalize_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signatyre public key",
                 "signature bytes",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "get_transaction_hash - catches not providing auth" do
      assert {:error, "no auth provided"} = Core.get_transaction_hash("signed transaction")
    end

    test "get_transaction_hash - catches missing password" do
      assert {:error, "no password provided"} =
               Core.get_transaction_hash("signed transaction",
                 api: [username: "goku"]
               )
    end

    test "get_transaction_hash - catches missing username" do
      assert {:error, "no username provided"} =
               Core.get_transaction_hash("signed transaction",
                 api: [password: "hello goku"]
               )
    end

    test "get_transaction_hash - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.get_transaction_hash("signed transaction",
                 api: [auth_index: 9]
               )
    end

    test "get_transaction_hash - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.get_transaction_hash("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "get_transaction_hash - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.get_transaction_hash("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "get_transaction_hash - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.get_transaction_hash("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "get_transaction_hash - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_transaction_hash("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "get_transaction_hash - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.get_transaction_hash("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "get_transaction_hash - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.get_transaction_hash("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "get_transaction_hash - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.get_transaction_hash("signed transaction",
                 api: [username: "one", password: "two"]
               )
    end

    test "get_transaction_hash - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_transaction_hash("signed transaction",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "submit_transaction - catches not providing auth" do
      assert {:error, "no auth provided"} = Core.submit_transaction("signed transaction")
    end

    test "submit_transaction - catches missing password" do
      assert {:error, "no password provided"} =
               Core.submit_transaction("signed transaction",
                 api: [username: "goku"]
               )
    end

    test "submit_transaction - catches missing username" do
      assert {:error, "no username provided"} =
               Core.submit_transaction("signed transaction",
                 api: [password: "hello goku"]
               )
    end

    test "submit_transaction - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.submit_transaction("signed transaction",
                 api: [auth_index: 9]
               )
    end

    test "submit_transaction - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.submit_transaction("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "submit_transaction - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.submit_transaction("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "submit_transaction - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.submit_transaction("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "submit_transaction - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.submit_transaction("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "submit_transaction - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.submit_transaction("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "submit_transaction - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.submit_transaction("signed transaction",
                 api: [auth_index: 1]
               )
    end

    test "submit_transaction - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.submit_transaction("signed transaction",
                 api: [username: "one", password: "two"]
               )
    end

    test "submit_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.submit_transaction("signed transaction",
                 api: [username: "hello", password: "dog"]
               )
    end

    test "get_public_keys - catches not providing auth" do
      assert {:error, "no auth provided"} = Core.get_public_keys()
    end

    test "get_public_keys - catches missing password" do
      assert {:error, "no password provided"} = Core.get_public_keys(api: [username: "goku"])
    end

    test "get_public_keys - catches missing username" do
      assert {:error, "no username provided"} =
               Core.get_public_keys(api: [password: "hello goku"])
    end

    test "get_public_keys - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.get_public_keys(api: [auth_index: 9])
    end

    test "get_public_keys - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.get_public_keys(api: [auth_index: 1])
    end

    test "get_public_keys - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} = Core.get_public_keys(api: [auth_index: 1])
    end

    test "get_public_keys - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} = Core.get_public_keys(api: [auth_index: 1])
    end

    test "get_public_keys - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_public_keys(api: [auth_index: 1])
    end

    test "get_public_keys - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.get_public_keys(api: [auth_index: 1])
    end

    test "get_public_keys - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.get_public_keys(api: [auth_index: 1])
    end

    test "get_public_keys - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.get_public_keys(api: [username: "one", password: "two"])
    end

    test "get_public_keys - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.get_public_keys(api: [username: "hello", password: "dog"])
    end

    test "sign_transaction - catches not providing auth" do
      assert {:error, "no auth provided"} =
               Core.sign_transaction("unsigned transaction", "public key")
    end

    test "sign_transaction - catches missing password" do
      assert {:error, "no password provided"} =
               Core.sign_transaction("unsigned transaction", "public key", api: [username: "goku"])
    end

    test "sign_transaction - catches missing username" do
      assert {:error, "no username provided"} =
               Core.sign_transaction("unsigned transaction", "public key",
                 api: [password: "hello goku"]
               )
    end

    test "sign_transaction - catches invalid auth_index" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf"
      )

      assert {:error, "invalid index for accessing usernames and passwords"} =
               Core.sign_transaction("unsigned transaction", "public key", api: [auth_index: 9])
    end

    test "sign_transaction - catches usernames and passwords length mismatch" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "admin",
        passwords: "admin sdfsdf, metrics"
      )

      assert {:error, "usernames and passwords length mismatch"} =
               Core.sign_transaction("unsigned transaction", "public key", api: [auth_index: 1])
    end

    test "sign_transaction - catches no usernames" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "",
        passwords: ""
      )

      assert {:error, "no usernames"} =
               Core.sign_transaction("unsigned transaction", "public key", api: [auth_index: 1])
    end

    test "sign_transaction - catches no passwords" do
      Application.put_env(:radixir, Radixir.Config,
        usernames: "hello",
        passwords: ""
      )

      assert {:error, "no passwords"} =
               Core.sign_transaction("unsigned transaction", "public key", api: [auth_index: 1])
    end

    test "sign_transaction - catches no configuration parameters found when looking for usernames and passwords" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.sign_transaction("unsigned transaction", "public key", api: [auth_index: 1])
    end

    test "sign_transaction - catches usernames not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "usernames not found in configuration"} =
               Core.sign_transaction("unsigned transaction", "public key", api: [auth_index: 1])
    end

    test "sign_transaction - catches passwords not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, usernames: "admin sdfsdf, metrics")

      assert {:error, "passwords not found in configuration"} =
               Core.sign_transaction("unsigned transaction", "public key", api: [auth_index: 1])
    end

    test "sign_transaction - catches Core_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, passwords: "admin sdfsdf, metrics")

      assert {:error, "core_api_url not found in configuration"} =
               Core.sign_transaction("unsigned transaction", "public key",
                 api: [username: "one", password: "two"]
               )
    end

    test "sign_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Core.sign_transaction("unsigned transaction", "public key",
                 api: [username: "hello", password: "dog"]
               )
    end
  end

  describe "get_network_status" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/network/status" == path

        assert %{
                 network_identifier: %{network: "stokenet"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_network_status(
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/network/status" == path

        assert %{
                 network_identifier: %{network: "network here"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_network_status(
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "get_entity_information" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/entity" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 entity_identifier: %{address: "address here"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_entity_information("address here",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/entity" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 entity_identifier: %{address: "address here"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_entity_information("address here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/entity" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 entity_identifier: %{
                   address: "address here",
                   sub_entity: %{
                     address: "subentity address",
                     metadata: %{validator_address: "validator address", epoch_unlock: 9000}
                   }
                 }
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_entity_information("address here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here",
                 sub_entity_address: "subentity address",
                 validator_address: "validator address",
                 epoch_unlock: 9000
               )
    end
  end

  describe "get_mempool_transactions" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/mempool" == path

        assert %{
                 network_identifier: %{network: "stokenet"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_mempool_transactions(
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/mempool" == path

        assert %{
                 network_identifier: %{network: "network here"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_mempool_transactions(
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "get_mempool_transaction" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/mempool/transaction" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 transaction_identifier: %{hash: "transaction hash here"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_mempool_transaction("transaction hash here",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/mempool/transaction" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 transaction_identifier: %{hash: "transaction hash here"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_mempool_transaction("transaction hash here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end
end
