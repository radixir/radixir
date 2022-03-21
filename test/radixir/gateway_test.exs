defmodule Radixir.GatewayTest do
  use ExUnit.Case, async: true

  import Mox

  alias Radixir.Gateway

  setup :verify_on_exit!

  describe "getting url from options" do
    test "get_info - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_info()
    end

    test "get_info - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} = Gateway.get_info()
    end

    test "derive_account_identifier - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.derive_account_identifier("")
    end

    test "derive_account_identifier - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.derive_account_identifier("")
    end

    test "get_account_balances - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_account_balances("")
    end

    test "get_account_balances - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.get_account_balances("")
    end

    test "get_stake_positions - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_stake_positions("")
    end

    test "get_stake_positions - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.get_stake_positions("")
    end

    test "get_unstake_positions - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_unstake_positions("")
    end

    test "get_unstake_positions - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.get_unstake_positions("")
    end

    test "get_account_transactions - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_account_transactions("")
    end

    test "get_account_transactions - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.get_account_transactions("")
    end

    test "get_native_token_info - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_native_token_info()
    end

    test "get_native_token_info - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.get_native_token_info()
    end

    test "get_token_info - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_token_info("")
    end

    test "get_token_info - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} = Gateway.get_token_info("")
    end

    test "derive_token_identifier - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.derive_token_identifier("", "")
    end

    test "derive_token_identifier - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.derive_token_identifier("", "")
    end

    test "get_validator - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_validator("")
    end

    test "get_validator - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} = Gateway.get_validator("")
    end

    test "derive_validator_identifier - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.derive_validator_identifier("")
    end

    test "derive_validator_identifier - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.derive_validator_identifier("")
    end

    test "get_validators - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_validators()
    end

    test "get_validators - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} = Gateway.get_validators()
    end

    test "get_validator_stakes - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_validator_stakes("")
    end

    test "get_validator_stakes - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.get_validator_stakes("")
    end

    test "get_transaction_rules - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_transaction_rules()
    end

    test "get_transaction_rules - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.get_transaction_rules()
    end

    test "build_create_token_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.build_create_token_transaction(
                 [
                   %{
                     name: "",
                     description: "",
                     icon_url: "",
                     url: "",
                     symbol: "",
                     is_supply_mutable: true,
                     granularity: "",
                     owner_address: "",
                     token_supply: "",
                     token_rri: "",
                     to_account_address: ""
                   }
                 ],
                 ""
               )
    end

    test "build_create_token_transaction - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.build_create_token_transaction(
                 [
                   %{
                     name: "",
                     description: "",
                     icon_url: "",
                     url: "",
                     symbol: "",
                     is_supply_mutable: true,
                     granularity: "",
                     owner_address: "",
                     token_supply: "",
                     token_rri: "",
                     to_account_address: ""
                   }
                 ],
                 ""
               )
    end

    test "build_transfer_tokens_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.build_transfer_tokens_transaction(
                 [%{from_address: "", to_address: "", amount: "", token_rri: ""}],
                 ""
               )
    end

    test "build_transfer_tokens_transaction - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.build_transfer_tokens_transaction(
                 [%{from_address: "", to_address: "", amount: "", token_rri: ""}],
                 ""
               )
    end

    test "build_stake_tokens_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.build_stake_tokens_transaction(
                 [%{from_address: "", to_validator_address: "", amount: "", token_rri: ""}],
                 ""
               )
    end

    test "build_stake_tokens_transaction - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.build_stake_tokens_transaction(
                 [%{from_address: "", to_validator_address: "", amount: "", token_rri: ""}],
                 ""
               )
    end

    test "build_unstake_tokens_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.build_unstake_tokens_transaction(
                 [%{from_validator_address: "", to_address: "", options: []}],
                 ""
               )
    end

    test "build_unstake_tokens_transaction - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.build_unstake_tokens_transaction(
                 [%{from_validator_address: "", to_address: "", options: []}],
                 ""
               )
    end

    test "build_mint_tokens_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.build_mint_tokens_transaction(
                 [%{to_address: "", amount: "", token_rri: ""}],
                 ""
               )
    end

    test "build_mint_tokens_transaction - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.build_mint_tokens_transaction(
                 [%{to_address: "", amount: "", token_rri: ""}],
                 ""
               )
    end

    test "build_burn_tokens_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.build_burn_tokens_transaction(
                 [%{from_address: "", amount: "", token_rri: ""}],
                 ""
               )
    end

    test "build_burn_tokens_transaction - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.build_burn_tokens_transaction(
                 [%{from_address: "", amount: "", token_rri: ""}],
                 ""
               )
    end

    test "build_register_validator_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.build_register_validator_transaction(
                 [""],
                 ""
               )
    end

    test "build_register_validator_transaction - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.build_register_validator_transaction(
                 [""],
                 ""
               )
    end

    test "build_unregister_validator_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.build_unregister_validator_transaction(
                 [""],
                 ""
               )
    end

    test "build_unregister_validator_transaction - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.build_unregister_validator_transaction(
                 [""],
                 ""
               )
    end

    test "finalize_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.finalize_transaction("", "", "")
    end

    test "finalize_transaction - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.finalize_transaction("", "", "")
    end

    test "submit_transaction - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.submit_transaction("")
    end

    test "submit_transaction - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.submit_transaction("")
    end

    test "get_transaction_status - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} = Gateway.get_transaction_status("")
    end

    test "get_transaction_status - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.get_transaction_status("")
    end

    test "create_token - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.create_token(
                 [
                   %{
                     name: "",
                     description: "",
                     icon_url: "",
                     url: "",
                     symbol: "",
                     is_supply_mutable: true,
                     granularity: "",
                     owner_address: "",
                     token_supply: "",
                     token_rri: "",
                     to_account_address: ""
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "create_token - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.create_token(
                 [
                   %{
                     name: "",
                     description: "",
                     icon_url: "",
                     url: "",
                     symbol: "",
                     is_supply_mutable: true,
                     granularity: "",
                     owner_address: "",
                     token_supply: "",
                     token_rri: "",
                     to_account_address: ""
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "transfer_tokens - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.transfer_tokens(
                 [
                   %{
                     from_address: "",
                     to_address: "",
                     token_rri: "",
                     amount: ""
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "transfer_tokens - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.transfer_tokens(
                 [
                   %{
                     from_address: "",
                     to_address: "",
                     token_rri: "",
                     amount: ""
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "stake_tokens - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.stake_tokens(
                 [
                   %{
                     from_address: "",
                     to_validator_address: "",
                     token_rri: "",
                     amount: ""
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "stake_tokens - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.stake_tokens(
                 [
                   %{
                     from_address: "",
                     to_validator_address: "",
                     token_rri: "",
                     amount: ""
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "unstake_tokens - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.unstake_tokens(
                 [
                   %{
                     from_validator_address: "",
                     to_address: "",
                     options: []
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "unstake_tokens - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.unstake_tokens(
                 [
                   %{
                     from_validator_address: "",
                     to_address: "",
                     options: []
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "mint_tokens - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.mint_tokens(
                 [
                   %{
                     to_address: "",
                     token_rri: "",
                     amount: ""
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "mint_tokens - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.mint_tokens(
                 [
                   %{
                     to_address: "",
                     token_rri: "",
                     amount: ""
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "burn_tokens - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.burn_tokens(
                 [
                   %{
                     from_address: "",
                     token_rri: "",
                     amount: ""
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "burn_tokens - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.burn_tokens(
                 [
                   %{
                     from_address: "",
                     token_rri: "",
                     amount: ""
                   }
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "register_validator - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.register_validator(
                 [
                   ""
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "register_validator - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.register_validator(
                 [
                   ""
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "unregister_validator - catches no configuration parameters found when looking for url" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Gateway.unregister_validator(
                 [
                   ""
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end

    test "unregister_validator - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.unregister_validator(
                 [
                   ""
                 ],
                 "",
                 "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
               )
    end
  end

  describe "derive_account_identifier/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url" == url
        assert "/account/derive" == path

        assert %{network_identifier: %{network: "stokenet"}, public_key: %{hex: "address here"}} =
                 body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.derive_account_identifier("address here", api: [url: "url"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.derive_account_identifier("address here",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/account/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.derive_account_identifier("address here",
                 network: "network here"
               )
    end
  end

  describe "get_account_balances/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/balances" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 account_identifier: %{address: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.get_account_balances("address here", api: [url: "url here"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/balances" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_account_balances("address here",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/balances" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_account_balances("address here",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/balances" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_account_balances("address here",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/account/balances" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_account_balances("address here",
                 network: "network here",
                 epoch: 9000
               )
    end
  end

  describe "get_stake_positions/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/stakes" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 account_identifier: %{address: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.get_stake_positions("address here", api: [url: "url here"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/stakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_stake_positions("address here",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/stakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_stake_positions("address here",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/stakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_stake_positions("address here",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/account/stakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_stake_positions("address here",
                 network: "network here",
                 epoch: 9000
               )
    end
  end

  describe "get_unstake_positions/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/unstakes" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 account_identifier: %{address: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.get_unstake_positions("address here", api: [url: "url here"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/unstakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_unstake_positions("address here",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/unstakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_unstake_positions("address here",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/unstakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_unstake_positions("address here",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/account/unstakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_unstake_positions("address here",
                 network: "network here",
                 epoch: 9000
               )
    end
  end

  describe "get_account_transactions/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/transactions" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 account_identifier: %{address: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.get_account_transactions("address here", api: [url: "url here"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/transactions" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_account_transactions("address here",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/transactions" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_account_transactions("address here",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/transactions" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_account_transactions("address here",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/transactions" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 cursor: "cursor here"
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_account_transactions("address here",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000,
                 cursor: "cursor here"
               )
    end

    test "checks request body is correct - 6" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/transactions" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 cursor: "cursor here",
                 limit: 9000
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_account_transactions("address here",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000,
                 cursor: "cursor here",
                 limit: 9000
               )
    end

    test "checks request body is correct - 7" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/account/transactions" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 cursor: "cursor here",
                 limit: 9000
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_account_transactions("address here",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000,
                 cursor: "cursor here",
                 limit: 9000
               )
    end

    test "checks request body is correct - 8" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/account/transactions" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 account_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 cursor: "cursor here",
                 limit: 9000
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_account_transactions("address here",
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000,
                 cursor: "cursor here",
                 limit: 9000
               )
    end
  end

  describe "get_native_token_info/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/token/native" == path

        assert %{
                 network_identifier: %{network: "stokenet"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.get_native_token_info(api: [url: "url here"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/token/native" == path

        assert %{
                 network_identifier: %{network: "network here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_native_token_info(
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/token/native" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_native_token_info(
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/token/native" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_native_token_info(
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/token/native" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_native_token_info(
                 network: "network here",
                 epoch: 9000
               )
    end
  end

  describe "get_token_info/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/token" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 token_identifier: %{rri: "token rri here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.get_token_info("token rri here", api: [url: "url here"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/token" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 token_identifier: %{rri: "token rri here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_token_info("token rri here",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/token" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 token_identifier: %{rri: "token rri here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_token_info("token rri here",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/token" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 token_identifier: %{rri: "token rri here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_token_info("token rri here",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/token" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 token_identifier: %{rri: "token rri here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_token_info("token rri here",
                 network: "network here",
                 epoch: 9000
               )
    end
  end

  describe "derive_token_identifier/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/token/derive" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 public_key: %{hex: "public key here"},
                 symbol: "symbol here"
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.derive_token_identifier("public key here", "symbol here",
                 api: [url: "url here"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/token/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "public key here"},
                 symbol: "symbol here"
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.derive_token_identifier("public key here", "symbol here",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/token/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "public key here"},
                 symbol: "symbol here"
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.derive_token_identifier("public key here", "symbol here",
                 network: "network here"
               )
    end
  end

  describe "get_validator/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 validator_identifier: %{address: "validator address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.get_validator("validator address here", api: [url: "url here"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 validator_identifier: %{address: "validator address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validator("validator address here",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 validator_identifier: %{address: "validator address here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validator("validator address here",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 validator_identifier: %{address: "validator address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validator("validator address here",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/validator" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 validator_identifier: %{address: "validator address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validator("validator address here",
                 network: "network here",
                 epoch: 9000
               )
    end
  end

  describe "derive_validator_identifier/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url" == url
        assert "/validator/derive" == path

        assert %{network_identifier: %{network: "stokenet"}, public_key: %{hex: "address here"}} =
                 body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.derive_validator_identifier("address here", api: [url: "url"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.derive_validator_identifier("address here",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/validator/derive" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 public_key: %{hex: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.derive_validator_identifier("address here",
                 network: "network here"
               )
    end
  end

  describe "get_validators/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validators" == path

        assert %{
                 network_identifier: %{network: "stokenet"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.get_validators(api: [url: "url here"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validators" == path

        assert %{
                 network_identifier: %{network: "network here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validators(
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validators" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validators(
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validators" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validators(
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/validators" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validators(
                 network: "network here",
                 epoch: 9000
               )
    end
  end

  describe "get_validator_stakes/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator/stakes" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 validator_identifier: %{address: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.get_validator_stakes("address here", api: [url: "url here"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator/stakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 validator_identifier: %{address: "address here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validator_stakes("address here",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator/stakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 validator_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validator_stakes("address here",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator/stakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 validator_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validator_stakes("address here",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator/stakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 validator_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 cursor: "cursor here"
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validator_stakes("address here",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000,
                 cursor: "cursor here"
               )
    end

    test "checks request body is correct - 6" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator/stakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 validator_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 cursor: "cursor here",
                 limit: 9000
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validator_stakes("address here",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000,
                 cursor: "cursor here",
                 limit: 9000
               )
    end

    test "checks request body is correct - 7" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/validator/stakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 validator_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 cursor: "cursor here",
                 limit: 9000
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validator_stakes("address here",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000,
                 cursor: "cursor here",
                 limit: 9000
               )
    end

    test "checks request body is correct - 8" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/validator/stakes" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 validator_identifier: %{address: "address here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 cursor: "cursor here",
                 limit: 9000
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_validator_stakes("address here",
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000,
                 cursor: "cursor here",
                 limit: 9000
               )
    end
  end

  describe "get_transaction_rules/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/rules" == path

        assert %{
                 network_identifier: %{network: "stokenet"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.get_transaction_rules(api: [url: "url here"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/rules" == path

        assert %{
                 network_identifier: %{network: "network here"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_transaction_rules(
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/rules" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_transaction_rules(
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/rules" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_transaction_rules(
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/rules" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_transaction_rules(
                 network: "network here",
                 epoch: 9000
               )
    end
  end

  describe "build_create_token_transaction/2" do
    setup do
      {:ok,
       create_token_params: %{
         name: "token name",
         description: "token description",
         icon_url: "token icon url",
         url: "token url",
         symbol: "token symbol",
         is_supply_mutable: true,
         granularity: "token granularity",
         owner_address: "token owner address",
         token_supply: "token supply",
         token_rri: "token rri",
         to_account_address: "to account address"
       }}
    end

    test "checks request body is correct - 1", %{create_token_params: create_token_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 actions: [
                   %{
                     type: "CreateTokenDefinition",
                     token_properties: %{
                       name: "token name",
                       description: "token description",
                       icon_url: "token icon url",
                       url: "token url",
                       symbol: "token symbol",
                       is_supply_mutable: true,
                       granularity: "token granularity",
                       owner: %{address: "token owner address"}
                     },
                     token_supply: %{value: "token supply", token_identifier: %{rri: "token rri"}},
                     to_account: %{address: "to account address"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_create_token_transaction([create_token_params], "fee payer address",
                 api: [url: "url here"]
               )
    end

    test "checks request body is correct - 2", %{create_token_params: create_token_params} do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "CreateTokenDefinition",
                     token_properties: %{
                       name: "token name",
                       description: "token description",
                       icon_url: "token icon url",
                       url: "token url",
                       symbol: "token symbol",
                       is_supply_mutable: true,
                       granularity: "token granularity",
                       owner: %{address: "token owner address"}
                     },
                     token_supply: %{value: "token supply", token_identifier: %{rri: "token rri"}},
                     to_account: %{address: "to account address"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_create_token_transaction([create_token_params], "fee payer address",
                 network: "network here"
               )
    end

    test "checks request body is correct - 3", %{create_token_params: create_token_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 actions: [
                   %{
                     type: "CreateTokenDefinition",
                     token_properties: %{
                       name: "token name",
                       description: "token description",
                       icon_url: "token icon url",
                       url: "token url",
                       symbol: "token symbol",
                       is_supply_mutable: true,
                       granularity: "token granularity",
                       owner: %{address: "token owner address"}
                     },
                     token_supply: %{value: "token supply", token_identifier: %{rri: "token rri"}},
                     to_account: %{address: "to account address"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_create_token_transaction([create_token_params], "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4", %{create_token_params: create_token_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 actions: [
                   %{
                     type: "CreateTokenDefinition",
                     token_properties: %{
                       name: "token name",
                       description: "token description",
                       icon_url: "token icon url",
                       url: "token url",
                       symbol: "token symbol",
                       is_supply_mutable: true,
                       granularity: "token granularity",
                       owner: %{address: "token owner address"}
                     },
                     token_supply: %{value: "token supply", token_identifier: %{rri: "token rri"}},
                     to_account: %{address: "to account address"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_create_token_transaction([create_token_params], "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5", %{create_token_params: create_token_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "CreateTokenDefinition",
                     token_properties: %{
                       name: "token name",
                       description: "token description",
                       icon_url: "token icon url",
                       url: "token url",
                       symbol: "token symbol",
                       is_supply_mutable: true,
                       granularity: "token granularity",
                       owner: %{address: "token owner address"}
                     },
                     token_supply: %{value: "token supply", token_identifier: %{rri: "token rri"}},
                     to_account: %{address: "to account address"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"},
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_create_token_transaction([create_token_params], "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               )
    end
  end

  describe "build_transfer_tokens_transaction/2" do
    setup do
      {:ok,
       transfer_tokens_params: %{
         amount: "transfer amount",
         from_address: "from address",
         token_rri: "token rri",
         to_address: "to address"
       }}
    end

    test "checks request body is correct - 1", %{transfer_tokens_params: transfer_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 actions: [
                   %{
                     type: "TransferTokens",
                     from_account: %{address: "from address"},
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_transfer_tokens_transaction(
                 [transfer_tokens_params],
                 "fee payer address",
                 api: [url: "url here"]
               )
    end

    test "checks request body is correct - 2", %{transfer_tokens_params: transfer_tokens_params} do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "TransferTokens",
                     from_account: %{address: "from address"},
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_transfer_tokens_transaction(
                 [transfer_tokens_params],
                 "fee payer address",
                 network: "network here"
               )
    end

    test "checks request body is correct - 3", %{transfer_tokens_params: transfer_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 actions: [
                   %{
                     type: "TransferTokens",
                     from_account: %{address: "from address"},
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_transfer_tokens_transaction(
                 [transfer_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4", %{transfer_tokens_params: transfer_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 actions: [
                   %{
                     type: "TransferTokens",
                     from_account: %{address: "from address"},
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_transfer_tokens_transaction(
                 [transfer_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5", %{transfer_tokens_params: transfer_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "TransferTokens",
                     from_account: %{address: "from address"},
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"},
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_transfer_tokens_transaction(
                 [transfer_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               )
    end
  end

  describe "build_stake_tokens_transaction/2" do
    setup do
      {:ok,
       stake_tokens_params: %{
         amount: "transfer amount",
         from_address: "from address",
         token_rri: "token rri",
         to_validator_address: "to address"
       }}
    end

    test "checks request body is correct - 1", %{stake_tokens_params: stake_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 actions: [
                   %{
                     type: "StakeTokens",
                     from_account: %{address: "from address"},
                     to_validator: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_stake_tokens_transaction(
                 [stake_tokens_params],
                 "fee payer address",
                 api: [url: "url here"]
               )
    end

    test "checks request body is correct - 2", %{stake_tokens_params: stake_tokens_params} do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "StakeTokens",
                     from_account: %{address: "from address"},
                     to_validator: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_stake_tokens_transaction(
                 [stake_tokens_params],
                 "fee payer address",
                 network: "network here"
               )
    end

    test "checks request body is correct - 3", %{stake_tokens_params: stake_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 actions: [
                   %{
                     type: "StakeTokens",
                     from_account: %{address: "from address"},
                     to_validator: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_stake_tokens_transaction(
                 [stake_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4", %{stake_tokens_params: stake_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 actions: [
                   %{
                     type: "StakeTokens",
                     from_account: %{address: "from address"},
                     to_validator: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_stake_tokens_transaction(
                 [stake_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5", %{stake_tokens_params: stake_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "StakeTokens",
                     from_account: %{address: "from address"},
                     to_validator: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"},
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_stake_tokens_transaction(
                 [stake_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               )
    end
  end

  describe "build_unstake_tokens_transaction/2" do
    setup do
      {:ok,
       unstake_tokens_params: %{
         from_validator_address: "from address",
         to_address: "to address"
       }}
    end

    test "checks request body is correct - 1", %{unstake_tokens_params: unstake_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 actions: [
                   %{
                     type: "UnstakeTokens",
                     from_validator: %{address: "from address"},
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      unstake_tokens_params_options = [amount: "transfer amount", token_rri: "token rri"]

      unstake_tokens_params =
        Map.put(unstake_tokens_params, :options, unstake_tokens_params_options)

      assert {:ok, _} =
               Gateway.build_unstake_tokens_transaction(
                 [unstake_tokens_params],
                 "fee payer address",
                 api: [url: "url here"]
               )
    end

    test "checks request body is correct - 2", %{unstake_tokens_params: unstake_tokens_params} do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "UnstakeTokens",
                     from_validator: %{address: "from address"},
                     to_account: %{address: "to address"},
                     unstake_percentage: 100
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      unstake_tokens_params_options = [unstake_percentage: 100]

      unstake_tokens_params =
        Map.put(unstake_tokens_params, :options, unstake_tokens_params_options)

      assert {:ok, _} =
               Gateway.build_unstake_tokens_transaction(
                 [unstake_tokens_params],
                 "fee payer address",
                 network: "network here"
               )
    end

    test "checks request body is correct - 3", %{unstake_tokens_params: unstake_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 actions: [
                   %{
                     type: "UnstakeTokens",
                     from_validator: %{address: "from address"},
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      unstake_tokens_params_options = [amount: "transfer amount", token_rri: "token rri"]

      unstake_tokens_params =
        Map.put(unstake_tokens_params, :options, unstake_tokens_params_options)

      assert {:ok, _} =
               Gateway.build_unstake_tokens_transaction(
                 [unstake_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4", %{unstake_tokens_params: unstake_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 actions: [
                   %{
                     type: "UnstakeTokens",
                     from_validator: %{address: "from address"},
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      unstake_tokens_params_options = [amount: "transfer amount", token_rri: "token rri"]

      unstake_tokens_params =
        Map.put(unstake_tokens_params, :options, unstake_tokens_params_options)

      assert {:ok, _} =
               Gateway.build_unstake_tokens_transaction(
                 [unstake_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5", %{unstake_tokens_params: unstake_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "UnstakeTokens",
                     from_validator: %{address: "from address"},
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"},
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               } = body

        {:ok, %{}}
      end)

      unstake_tokens_params_options = [amount: "transfer amount", token_rri: "token rri"]

      unstake_tokens_params =
        Map.put(unstake_tokens_params, :options, unstake_tokens_params_options)

      assert {:ok, _} =
               Gateway.build_unstake_tokens_transaction(
                 [unstake_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               )
    end
  end

  describe "build_mint_tokens_transaction/2" do
    setup do
      {:ok,
       mint_tokens_params: %{
         amount: "transfer amount",
         token_rri: "token rri",
         to_address: "to address"
       }}
    end

    test "checks request body is correct - 1", %{mint_tokens_params: mint_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 actions: [
                   %{
                     type: "MintTokens",
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_mint_tokens_transaction(
                 [mint_tokens_params],
                 "fee payer address",
                 api: [url: "url here"]
               )
    end

    test "checks request body is correct - 2", %{mint_tokens_params: mint_tokens_params} do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "MintTokens",
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_mint_tokens_transaction(
                 [mint_tokens_params],
                 "fee payer address",
                 network: "network here"
               )
    end

    test "checks request body is correct - 3", %{mint_tokens_params: mint_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 actions: [
                   %{
                     type: "MintTokens",
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_mint_tokens_transaction(
                 [mint_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4", %{mint_tokens_params: mint_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 actions: [
                   %{
                     type: "MintTokens",
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_mint_tokens_transaction(
                 [mint_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5", %{mint_tokens_params: mint_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "MintTokens",
                     to_account: %{address: "to address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"},
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_mint_tokens_transaction(
                 [mint_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               )
    end
  end

  describe "build_burn_tokens_transaction/2" do
    setup do
      {:ok,
       transfer_tokens_params: %{
         amount: "transfer amount",
         from_address: "from address",
         token_rri: "token rri"
       }}
    end

    test "checks request body is correct - 1", %{transfer_tokens_params: transfer_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 actions: [
                   %{
                     type: "BurnTokens",
                     from_account: %{address: "from address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_burn_tokens_transaction(
                 [transfer_tokens_params],
                 "fee payer address",
                 api: [url: "url here"]
               )
    end

    test "checks request body is correct - 2", %{transfer_tokens_params: transfer_tokens_params} do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "BurnTokens",
                     from_account: %{address: "from address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_burn_tokens_transaction(
                 [transfer_tokens_params],
                 "fee payer address",
                 network: "network here"
               )
    end

    test "checks request body is correct - 3", %{transfer_tokens_params: transfer_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 actions: [
                   %{
                     type: "BurnTokens",
                     from_account: %{address: "from address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_burn_tokens_transaction(
                 [transfer_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4", %{transfer_tokens_params: transfer_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 actions: [
                   %{
                     type: "BurnTokens",
                     from_account: %{address: "from address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_burn_tokens_transaction(
                 [transfer_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5", %{transfer_tokens_params: transfer_tokens_params} do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "BurnTokens",
                     from_account: %{address: "from address"},
                     amount: %{value: "transfer amount", token_identifier: %{rri: "token rri"}}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"},
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_burn_tokens_transaction(
                 [transfer_tokens_params],
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               )
    end
  end

  describe "build_register_validator_transaction/2" do
    setup do
      {:ok, register_validator_params: ["address here"]}
    end

    test "checks request body is correct - 1", %{
      register_validator_params: register_validator_params
    } do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 actions: [
                   %{
                     type: "RegisterValidator",
                     validator: %{address: "address here"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_register_validator_transaction(
                 register_validator_params,
                 "fee payer address",
                 api: [url: "url here"]
               )
    end

    test "checks request body is correct - 2", %{
      register_validator_params: register_validator_params
    } do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "RegisterValidator",
                     validator: %{address: "address here"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_register_validator_transaction(
                 register_validator_params,
                 "fee payer address",
                 network: "network here"
               )
    end

    test "checks request body is correct - 3", %{
      register_validator_params: register_validator_params
    } do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 actions: [
                   %{
                     type: "RegisterValidator",
                     validator: %{address: "address here"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_register_validator_transaction(
                 register_validator_params,
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4", %{
      register_validator_params: register_validator_params
    } do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 actions: [
                   %{
                     type: "RegisterValidator",
                     validator: %{address: "address here"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_register_validator_transaction(
                 register_validator_params,
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5", %{
      register_validator_params: register_validator_params
    } do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "RegisterValidator",
                     validator: %{address: "address here"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"},
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_register_validator_transaction(
                 register_validator_params,
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               )
    end
  end

  describe "build_unregister_validator_transaction/2" do
    setup do
      {:ok, register_validator_params: ["address here"]}
    end

    test "checks request body is correct - 1", %{
      register_validator_params: register_validator_params
    } do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 actions: [
                   %{
                     type: "UnregisterValidator",
                     validator: %{address: "address here"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_unregister_validator_transaction(
                 register_validator_params,
                 "fee payer address",
                 api: [url: "url here"]
               )
    end

    test "checks request body is correct - 2", %{
      register_validator_params: register_validator_params
    } do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "UnregisterValidator",
                     validator: %{address: "address here"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_unregister_validator_transaction(
                 register_validator_params,
                 "fee payer address",
                 network: "network here"
               )
    end

    test "checks request body is correct - 3", %{
      register_validator_params: register_validator_params
    } do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 },
                 actions: [
                   %{
                     type: "UnregisterValidator",
                     validator: %{address: "address here"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_unregister_validator_transaction(
                 register_validator_params,
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4", %{
      register_validator_params: register_validator_params
    } do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 at_state_identifier: %{
                   epoch: 9000
                 },
                 actions: [
                   %{
                     type: "UnregisterValidator",
                     validator: %{address: "address here"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_unregister_validator_transaction(
                 register_validator_params,
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5", %{
      register_validator_params: register_validator_params
    } do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/build" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 actions: [
                   %{
                     type: "UnregisterValidator",
                     validator: %{address: "address here"}
                   }
                 ],
                 fee_payer: %{address: "fee payer address"},
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.build_unregister_validator_transaction(
                 register_validator_params,
                 "fee payer address",
                 api: [url: "url here"],
                 network: "network here",
                 message: "hello hello",
                 disable_token_mint_and_burn: true
               )
    end
  end

  describe "finalize_transaction/4" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url" == url
        assert "/transaction/finalize" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 unsigned_transaction: "unsigned transaction",
                 signature: %{
                   public_key: %{hex: "signature public key"},
                   bytes: "signature bytes"
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.finalize_transaction(
                 "unsigned transaction",
                 "signature public key",
                 "signature bytes",
                 api: [url: "url"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/finalize" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 unsigned_transaction: "unsigned transaction",
                 signature: %{
                   public_key: %{hex: "signature public key"},
                   bytes: "signature bytes"
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.finalize_transaction(
                 "unsigned transaction",
                 "signature public key",
                 "signature bytes",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/finalize" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 unsigned_transaction: "unsigned transaction",
                 signature: %{
                   public_key: %{hex: "signature public key"},
                   bytes: "signature bytes"
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.finalize_transaction(
                 "unsigned transaction",
                 "signature public key",
                 "signature bytes",
                 network: "network here"
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/finalize" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 unsigned_transaction: "unsigned transaction",
                 signature: %{
                   public_key: %{hex: "signature public key"},
                   bytes: "signature bytes"
                 },
                 submit: true
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.finalize_transaction(
                 "unsigned transaction",
                 "signature public key",
                 "signature bytes",
                 api: [url: "url here"],
                 network: "network here",
                 submit: true
               )
    end
  end

  describe "submit_transaction/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url" == url
        assert "/transaction/submit" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 signed_transaction: "signed transaction"
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.submit_transaction(
                 "signed transaction",
                 api: [url: "url"]
               )
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/submit" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 signed_transaction: "signed transaction"
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.submit_transaction(
                 "signed transaction",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/submit" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 signed_transaction: "signed transaction"
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.submit_transaction(
                 "signed transaction",
                 network: "network here"
               )
    end
  end

  describe "get_transaction_status/2" do
    test "checks request body is correct - 1" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/status" == path

        assert %{
                 network_identifier: %{network: "stokenet"},
                 transaction_identifier: %{hash: "transaction hash"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} = Gateway.get_transaction_status("transaction hash", api: [url: "url here"])
    end

    test "checks request body is correct - 2" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/status" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 transaction_identifier: %{hash: "transaction hash"}
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_transaction_status(
                 "transaction hash",
                 api: [url: "url here"],
                 network: "network here"
               )
    end

    test "checks request body is correct - 3" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/status" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 transaction_identifier: %{hash: "transaction hash"},
                 at_state_identifier: %{
                   version: 9000,
                   timestamp: "timestamp here",
                   epoch: 9000,
                   round: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_transaction_status(
                 "transaction hash",
                 api: [url: "url here"],
                 network: "network here",
                 version: 9000,
                 timestamp: "timestamp here",
                 epoch: 9000,
                 round: 9000
               )
    end

    test "checks request body is correct - 4" do
      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "url here" == url
        assert "/transaction/status" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 transaction_identifier: %{hash: "transaction hash"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_transaction_status(
                 "transaction hash",
                 api: [url: "url here"],
                 network: "network here",
                 epoch: 9000
               )
    end

    test "checks request body is correct - 5" do
      Application.put_env(:radixir, Radixir.Config, gateway_api_url: "hello url here")

      Radixir.MockHTTP
      |> expect(:post, fn url, path, body, _options ->
        assert "hello url here" == url
        assert "/transaction/status" == path

        assert %{
                 network_identifier: %{network: "network here"},
                 transaction_identifier: %{hash: "transaction hash"},
                 at_state_identifier: %{
                   epoch: 9000
                 }
               } = body

        {:ok, %{}}
      end)

      assert {:ok, _} =
               Gateway.get_transaction_status(
                 "transaction hash",
                 network: "network here",
                 epoch: 9000
               )
    end
  end
end
