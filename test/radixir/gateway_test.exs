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
                 [%{from_validator_address: "", to_address: "", token_rri: ""}],
                 ""
               )
    end

    test "build_unstake_tokens_transaction - catches gateway_api_url not being found in configuration" do
      Application.put_env(:radixir, Radixir.Config, test: "hello")

      assert {:error, "gateway_api_url not found in configuration"} =
               Gateway.build_unstake_tokens_transaction(
                 [%{from_validator_address: "", to_address: "", token_rri: ""}],
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
                     token_rri: "",
                     amount: ""
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
                     token_rri: "",
                     amount: ""
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
  end
end
