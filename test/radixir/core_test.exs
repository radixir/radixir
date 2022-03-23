defmodule Radixir.CoreTest do
  use ExUnit.Case, async: false

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

  describe "get_committed_transactions" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/transactions" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 state_identifier: %{state_version: 10}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_committed_transactions(10,
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/transactions" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 state_identifier: %{state_version: 10}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_committed_transactions(10,
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/transactions" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 state_identifier: %{
                   state_version: 10,
                   transaction_accumulator: "transaction accumulator"
                 },
                 limit: 10
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_committed_transactions(10,
                 api: [url: "url here", username: "username here", password: "password here"],
                 transaction_accumulator: "transaction accumulator",
                 limit: 10,
                 network: "network here"
               )
    end
  end

  describe "derive_account_entity_identifier" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 public_key: %{hex: "public key here"},
                 metadata: %{type: "Account"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_account_entity_identifier("public key here",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "public key here"},
                 metadata: %{type: "Account"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_account_entity_identifier("public key here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "derive_validator_entity_identifier" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 public_key: %{hex: "public key here"},
                 metadata: %{type: "Validator"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_validator_entity_identifier("public key here",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "public key here"},
                 metadata: %{type: "Validator"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_validator_entity_identifier("public key here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "derive_token_entity_identifier" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 public_key: %{hex: "public key here"},
                 metadata: %{type: "Token", symbol: "symbol here"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "public key here"},
                 metadata: %{type: "Token", symbol: "symbol here"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_token_entity_identifier("public key here", "symbol here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "derive_prepared_stakes_entity_identifier" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 public_key: %{hex: "public key here"},
                 metadata: %{
                   type: "PreparedStakes",
                   validator: %{address: "validator address here"}
                 }
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "public key here"},
                 metadata: %{
                   type: "PreparedStakes",
                   validator: %{address: "validator address here"}
                 }
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "public key here"},
                 metadata: %{
                   type: "PreparedStakes",
                   validator: %{
                     address: "validator address here",
                     sub_entity: %{
                       address: "subentity address here",
                       metadata: %{
                         validator_address: "validator address here",
                         epoch_unlock: 9000
                       }
                     }
                   }
                 }
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_prepared_stakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here",
                 sub_entity_address: "subentity address here",
                 validator_address: "validator address here",
                 epoch_unlock: 9000
               )
    end
  end

  describe "derive_prepared_unstakes_entity_identifier" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 public_key: %{hex: "public key here"},
                 metadata: %{type: "PreparedUnstakes"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "public key here"},
                 metadata: %{type: "PreparedUnstakes"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_prepared_unstakes_entity_identifier("public key here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "derive_exiting_unstakes_entity_identifier" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 public_key: %{hex: "public key here"},
                 metadata: %{
                   type: "ExitingUnstakes",
                   validator: %{address: "validator address here"},
                   epoch_unlock: 9
                 }
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 9,
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "public key here"},
                 metadata: %{
                   type: "ExitingUnstakes",
                   validator: %{address: "validator address here"},
                   epoch_unlock: 9
                 }
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 9,
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "public key here"},
                 metadata: %{
                   type: "ExitingUnstakes",
                   validator: %{
                     address: "validator address here",
                     sub_entity: %{
                       address: "subentity address here",
                       metadata: %{
                         validator_address: "validator address here",
                         epoch_unlock: 9000
                       }
                     }
                   },
                   epoch_unlock: 9
                 }
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_exiting_unstakes_entity_identifier(
                 "public key here",
                 "validator address here",
                 9,
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here",
                 sub_entity_address: "subentity address here",
                 validator_address: "validator address here",
                 epoch_unlock: 9000
               )
    end
  end

  describe "derive_validator_system_entity_identifier" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 public_key: %{hex: "public key here"},
                 metadata: %{type: "ValidatorSystem"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "public key here"},
                 metadata: %{type: "ValidatorSystem"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.derive_validator_system_entity_identifier("public key here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "build_transaction" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/build" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 operation_groups: [],
                 fee_payer: %{
                   address: "fee payer address here"
                 }
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.build_transaction(
                 [],
                 "fee payer address here",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 operation_groups: [],
                 fee_payer: %{
                   address: "fee payer address here"
                 }
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.build_transaction(
                 [],
                 "fee payer address here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 operation_groups: [],
                 fee_payer: %{
                   address: "fee payer address here",
                   sub_entity: %{
                     address: "subentity address here",
                     metadata: %{
                       validator_address: "validator address here",
                       epoch_unlock: 9000
                     }
                   }
                 },
                 message: "message here",
                 disable_resource_allocate_and_destroy: true
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.build_transaction(
                 [],
                 "fee payer address here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here",
                 sub_entity_address: "subentity address here",
                 validator_address: "validator address here",
                 epoch_unlock: 9000,
                 message: "message here",
                 disable_resource_allocate_and_destroy: true
               )
    end
  end

  describe "parse_transaction" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/parse" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 transaction: "transaction here",
                 signed: true
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.parse_transaction("transaction here", true,
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/parse" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 transaction: "transaction here",
                 signed: true
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.parse_transaction("transaction here", true,
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "finalize_transaction" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/finalize" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 unsigned_transaction: "unsigned transaction",
                 signature: %{
                   public_key: %{hex: "signature public key"},
                   bytes: "signature bytes"
                 }
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signature public key",
                 "signature bytes",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/finalize" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 unsigned_transaction: "unsigned transaction",
                 signature: %{
                   public_key: %{hex: "signature public key"},
                   bytes: "signature bytes"
                 }
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.finalize_transaction(
                 "unsigned transaction",
                 "signature public key",
                 "signature bytes",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "get_transaction_hash" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/hash" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 signed_transaction: "signed transaction"
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_transaction_hash(
                 "signed transaction",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/hash" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 signed_transaction: "signed transaction"
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_transaction_hash(
                 "signed transaction",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "submit_transaction" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/submit" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 signed_transaction: "signed transaction"
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.submit_transaction(
                 "signed transaction",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/construction/submit" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 signed_transaction: "signed transaction"
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.submit_transaction(
                 "signed transaction",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "get_public_keys" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/key/list" == path

        assert %{
                 network_identifier: %{network: "stokenet"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_public_keys(
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/key/list" == path

        assert %{
                 network_identifier: %{network: "network here"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.get_public_keys(
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "sign_transaction" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/key/sign" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 unsigned_transaction: "unsigned transaction",
                 public_key: %{hex: "public key here"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.sign_transaction("unsigned transaction", "public key here",
                 api: [url: "url here", username: "username here", password: "password here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, options ->
        assert "url here" == url
        assert "/key/sign" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 unsigned_transaction: "unsigned transaction",
                 public_key: %{hex: "public key here"}
               } = body

        assert [auth: {"username here", "password here"}] == options

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Core.sign_transaction("unsigned transaction", "public key here",
                 api: [url: "url here", username: "username here", password: "password here"],
                 network: "network here"
               )
    end
  end

  describe "build_operation_type" do
    test "checks returned value - 1" do
      assert %{type: "Resource"} = Core.build_operation_type("Resource")
    end

    test "checks returned value - 2" do
      assert %{type: "Data"} = Core.build_operation_type("Data")
    end

    test "checks returned value - 3" do
      assert %{type: "ResourceAndData"} = Core.build_operation_type("ResourceAndData")
    end

    test "checks returned value - 4" do
      assert_raise ArgumentError, fn -> Core.build_operation_type("Junk") end
    end
  end

  describe "build_operation_entity_identifier" do
    test "checks returned value - 1" do
      assert %{
               entity_identifier: %{
                 address: "address here",
                 sub_entity: %{
                   address: "subentity address here",
                   metadata: %{validator_address: "validator address here", epoch_unlock: 9000}
                 }
               }
             } =
               Core.build_operation_entity_identifier("address here",
                 sub_entity_address: "subentity address here",
                 validator_address: "validator address here",
                 epoch_unlock: 9000
               )
    end
  end

  describe "build_operation_substate" do
    test "checks returned value - 1" do
      assert %{
               substate: %{
                 substate_operation: "BOOTUP",
                 substate_identifier: %{identifier: "substate identifier"}
               }
             } = Core.build_operation_substate("BOOTUP", "substate identifier")
    end

    test "checks returned value - 2" do
      assert %{
               substate: %{
                 substate_operation: "SHUTDOWN",
                 substate_identifier: %{identifier: "substate identifier"}
               }
             } = Core.build_operation_substate("SHUTDOWN", "substate identifier")
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_substate("Junk", "substate identifier")
      end
    end
  end

  describe "build_operation_amount_token" do
    test "checks returned value - 1" do
      assert %{
               amount: %{
                 value: "amount",
                 resource_identifier: %{
                   type: "Token",
                   rri: "token rri"
                 }
               }
             } = Core.build_operation_amount_token("amount", "token rri")
    end
  end

  describe "build_operation_amount_stake_unit" do
    test "checks returned value - 1" do
      assert %{
               amount: %{
                 value: "amount",
                 resource_identifier: %{
                   type: "StakeUnit",
                   validator_address: "validator address"
                 }
               }
             } = Core.build_operation_amount_stake_unit("amount", "validator address")
    end
  end

  describe "build_operation_data_unclaimed_radix_engine_address" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "UnclaimedRadixEngineAddress"
                 }
               }
             } = Core.build_operation_data_unclaimed_radix_engine_address("CREATE")
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "UnclaimedRadixEngineAddress"
                 }
               }
             } = Core.build_operation_data_unclaimed_radix_engine_address("DELETE")
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_unclaimed_radix_engine_address("junk")
      end
    end
  end

  describe "build_operation_data_round_data" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "RoundData",
                   round: 1,
                   timestamp: 2
                 }
               }
             } = Core.build_operation_data_round_data("CREATE", 1, 2)
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "RoundData",
                   round: 1,
                   timestamp: 2
                 }
               }
             } = Core.build_operation_data_round_data("DELETE", 1, 2)
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_round_data("junk", 1, 2)
      end
    end
  end

  describe "build_operation_data_epoch_data" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "EpochData",
                   epoch: 9
                 }
               }
             } = Core.build_operation_data_epoch_data("CREATE", 9)
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "EpochData",
                   epoch: 9
                 }
               }
             } = Core.build_operation_data_epoch_data("DELETE", 9)
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_epoch_data("junk", 9)
      end
    end
  end

  describe "build_operation_data_token_data" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "TokenData",
                   granularity: "9",
                   is_mutable: true,
                   owner: %{
                     address: "address here",
                     sub_entity: %{
                       address: "subentity address",
                       metadata: %{validator_address: "validator address", epoch_unlock: 90}
                     }
                   }
                 }
               }
             } =
               Core.build_operation_data_token_data("CREATE", "9", true,
                 address: "address here",
                 sub_entity_address: "subentity address",
                 validator_address: "validator address",
                 epoch_unlock: 90
               )
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "TokenData",
                   granularity: "9",
                   is_mutable: true,
                   owner: %{
                     address: "address here",
                     sub_entity: %{
                       address: "subentity address",
                       metadata: %{validator_address: "validator address", epoch_unlock: 90}
                     }
                   }
                 }
               }
             } =
               Core.build_operation_data_token_data("DELETE", "9", true,
                 address: "address here",
                 sub_entity_address: "subentity address",
                 validator_address: "validator address",
                 epoch_unlock: 90
               )
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_token_data("junk", "9", true,
          address: "address here",
          sub_entity_address: "subentity address",
          validator_address: "validator address",
          epoch_unlock: 90
        )
      end
    end
  end

  describe "build_operation_data_token_metadata" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "TokenMetaData",
                   symbol: "token symbol",
                   name: "name here",
                   description: "description here",
                   url: "url here",
                   icon_url: "icon url here"
                 }
               }
             } =
               Core.build_operation_data_token_metadata("CREATE", "token symbol",
                 name: "name here",
                 description: "description here",
                 url: "url here",
                 icon_url: "icon url here"
               )
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "TokenMetaData",
                   symbol: "token symbol",
                   name: "name here",
                   description: "description here",
                   url: "url here",
                   icon_url: "icon url here"
                 }
               }
             } =
               Core.build_operation_data_token_metadata("DELETE", "token symbol",
                 name: "name here",
                 description: "description here",
                 url: "url here",
                 icon_url: "icon url here"
               )
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_token_metadata("junk", "token symbol",
          name: "name here",
          description: "description here",
          url: "url here",
          icon_url: "icon url here"
        )
      end
    end
  end

  describe "build_operation_data_prepared_validator_registered" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "PreparedValidatorRegistered",
                   registered: true,
                   epoch: 90
                 }
               }
             } =
               Core.build_operation_data_prepared_validator_registered("CREATE", true, epoch: 90)
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "PreparedValidatorRegistered",
                   registered: true,
                   epoch: 90
                 }
               }
             } =
               Core.build_operation_data_prepared_validator_registered("DELETE", true, epoch: 90)
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_prepared_validator_registered("junk", true, epoch: 90)
      end
    end
  end

  describe "build_operation_data_prepared_validator_owner" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "PreparedValidatorOwner",
                   owner: %{
                     address: "address here",
                     sub_entity: %{
                       address: "subentity address",
                       metadata: %{validator_address: "validator address", epoch_unlock: 90}
                     }
                   }
                 }
               }
             } =
               Core.build_operation_data_prepared_validator_owner("CREATE", "address here",
                 sub_entity_address: "subentity address",
                 validator_address: "validator address",
                 epoch_unlock: 90
               )
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "PreparedValidatorOwner",
                   owner: %{
                     address: "address here",
                     sub_entity: %{
                       address: "subentity address",
                       metadata: %{validator_address: "validator address", epoch_unlock: 90}
                     }
                   }
                 }
               }
             } =
               Core.build_operation_data_prepared_validator_owner("DELETE", "address here",
                 sub_entity_address: "subentity address",
                 validator_address: "validator address",
                 epoch_unlock: 90
               )
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_prepared_validator_owner("junk", "address here",
          sub_entity_address: "subentity address",
          validator_address: "validator address",
          epoch_unlock: 90
        )
      end
    end
  end

  describe "build_operation_data_prepared_validator_fee" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "PreparedValidatorFee",
                   fee: 90,
                   epoch: 90
                 }
               }
             } = Core.build_operation_data_prepared_validator_fee("CREATE", 90, epoch: 90)
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "PreparedValidatorFee",
                   fee: 90,
                   epoch: 90
                 }
               }
             } = Core.build_operation_data_prepared_validator_fee("DELETE", 90, epoch: 90)
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_prepared_validator_fee("junk", 90, epoch: 90)
      end
    end
  end

  describe "build_operation_data_validator_metadata" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "ValidatorMetadata",
                   name: "name here",
                   url: "url here"
                 }
               }
             } =
               Core.build_operation_data_validator_metadata(
                 "CREATE",
                 "name here",
                 "url here"
               )
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "ValidatorMetadata",
                   name: "name here",
                   url: "url here"
                 }
               }
             } =
               Core.build_operation_data_validator_metadata(
                 "DELETE",
                 "name here",
                 "url here"
               )
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_validator_metadata("junk", "name here", "url here")
      end
    end
  end

  describe "build_operation_data_validator_bft_data" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "ValidatorBFTData",
                   proposals_completed: 90,
                   proposals_missed: 80
                 }
               }
             } =
               Core.build_operation_data_validator_bft_data(
                 "CREATE",
                 90,
                 80
               )
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "ValidatorBFTData",
                   proposals_completed: 90,
                   proposals_missed: 80
                 }
               }
             } =
               Core.build_operation_data_validator_bft_data(
                 "DELETE",
                 90,
                 80
               )
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_validator_bft_data("junk", 90, 80)
      end
    end
  end

  describe "build_operation_data_validator_allow_delegation" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "ValidatorAllowDelegation",
                   allow_delegation: true
                 }
               }
             } =
               Core.build_operation_data_validator_allow_delegation(
                 "CREATE",
                 true
               )
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "ValidatorAllowDelegation",
                   allow_delegation: true
                 }
               }
             } =
               Core.build_operation_data_validator_allow_delegation(
                 "DELETE",
                 true
               )
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_validator_allow_delegation("junk", true)
      end
    end
  end

  describe "build_operation_data_validator_data" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "ValidatorData",
                   owner: %{
                     address: "address here",
                     sub_entity: %{
                       address: "subentity address",
                       metadata: %{validator_address: "validator address", epoch_unlock: 90}
                     }
                   },
                   registered: true,
                   fee: 90
                 }
               }
             } =
               Core.build_operation_data_validator_data("CREATE", "address here", true, 90,
                 sub_entity_address: "subentity address",
                 validator_address: "validator address",
                 epoch_unlock: 90
               )
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "ValidatorData",
                   owner: %{
                     address: "address here",
                     sub_entity: %{
                       address: "subentity address",
                       metadata: %{validator_address: "validator address", epoch_unlock: 90}
                     }
                   },
                   registered: true,
                   fee: 90
                 }
               }
             } =
               Core.build_operation_data_validator_data("DELETE", "address here", true, 90,
                 sub_entity_address: "subentity address",
                 validator_address: "validator address",
                 epoch_unlock: 90
               )
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_validator_data("junk", "address here", true, 90,
          sub_entity_address: "subentity address",
          validator_address: "validator address",
          epoch_unlock: 90
        )
      end
    end
  end

  describe "build_operation_data_validator_system_metadata" do
    test "checks returned value - 1" do
      assert %{
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "ValidatorSystemMetadata",
                   data: "data here"
                 }
               }
             } =
               Core.build_operation_data_validator_system_metadata(
                 "CREATE",
                 "data here"
               )
    end

    test "checks returned value - 2" do
      assert %{
               data: %{
                 action: "DELETE",
                 data_object: %{
                   type: "ValidatorSystemMetadata",
                   data: "data here"
                 }
               }
             } =
               Core.build_operation_data_validator_system_metadata(
                 "DELETE",
                 "data here"
               )
    end

    test "checks returned value - 3" do
      assert_raise ArgumentError, fn ->
        Core.build_operation_data_validator_system_metadata("junk", "data here")
      end
    end
  end

  describe "build_operation_metadata" do
    test "checks returned value - 1" do
      assert %{metadata: %{substate_data_hex: "substate data hex"}} =
               Core.build_operation_metadata("substate data hex")
    end
  end

  describe "build_operation" do
    test "checks returned value - 1" do
      type = Core.build_operation_type("Resource")

      entity_identifier =
        Core.build_operation_entity_identifier("address here",
          sub_entity_address: "subentity address here",
          validator_address: "validator address here",
          epoch_unlock: 9000
        )

      substate = Core.build_operation_substate("BOOTUP", "substate identifier")
      amount = Core.build_operation_amount_token("amount", "token rri")
      data = Core.build_operation_data_round_data("CREATE", 1, 2)
      metadata = Core.build_operation_metadata("substate data hex")

      assert %{
               metadata: %{substate_data_hex: "substate data hex"},
               data: %{
                 action: "CREATE",
                 data_object: %{
                   type: "RoundData",
                   round: 1,
                   timestamp: 2
                 }
               },
               amount: %{
                 value: "amount",
                 resource_identifier: %{
                   type: "Token",
                   rri: "token rri"
                 }
               },
               substate: %{
                 substate_operation: "BOOTUP",
                 substate_identifier: %{identifier: "substate identifier"}
               },
               type: "Resource",
               entity_identifier: %{
                 address: "address here",
                 sub_entity: %{
                   address: "subentity address here",
                   metadata: %{validator_address: "validator address here", epoch_unlock: 9000}
                 }
               }
             } =
               Core.build_operation(type, entity_identifier,
                 substate: substate,
                 amount: amount,
                 data: data,
                 metadata: metadata
               )
    end
  end

  describe "build_operation_group" do
    test "checks returned value - 1" do
      assert %{operations: []} = Core.build_operation_group([])
    end
  end
end
