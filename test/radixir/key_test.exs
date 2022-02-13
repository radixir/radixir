defmodule Radixir.KeyTest do
  use ExUnit.Case, async: true
  doctest Radixir.Key

  alias Radixir.Key

  describe "generate/0" do
    test "generate new key + addresses" do
      assert %{
               mainnet_address: _mainnet_address,
               testnet_address: _testnet_address,
               public_key: _public_key,
               private_key: _private_key
             } = Key.generate()
    end
  end

  describe "from_private_key/1" do
    test "converts a private key to a key + addresses" do
      assert {:ok,
              %{
                mainnet_address:
                  "rdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmceghq5a",
                private_key: "ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17",
                public_key: "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f",
                testnet_address:
                  "tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7"
              }} =
               Key.from_private_key(
                 "ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17"
               )
    end

    test "fails to decode private key" do
      assert {:error, "could not decode private_key"} = Key.from_private_key("hello radix")
    end

    test "catches incorrectly formated private key" do
      assert {:error, "invalid format for private_key"} = Key.from_private_key("ed50")
    end
  end

  describe "address_to_public_key/1" do
    test "converts an address to its public key" do
      assert {:ok, "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f"} =
               Key.address_to_public_key(
                 "tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7"
               )
    end
  end

  describe "private_key_to_secret_integer/1" do
    test "converts a private key to its secret integer" do
      assert {:ok,
              107_340_927_595_134_471_984_420_820_489_673_630_767_605_194_678_966_104_711_498_635_548_873_815_202_327} =
               Key.private_key_to_secret_integer(
                 "ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17"
               )
    end

    test "fails to decode private key" do
      assert {:error, "could not decode private_key"} =
               Key.private_key_to_secret_integer("hello radix")
    end

    test "catches incorrectly formated private key" do
      assert {:error, "invalid format for private_key"} =
               Key.private_key_to_secret_integer("ed50")
    end
  end

  describe "sign_data/2" do
    test "signs data with provided private key" do
      assert {:ok,
              "304402206f2c0f3a70c23879a44a2910f9b060e59d5b96e350605fdbee2a7a265ca503c302201043a8a957353744608c86824c286034e6166be475c7c096527a225cbdf90d0a"} =
               Key.sign_data(
                 "68656C6C6F207261646978",
                 "ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17"
               )
    end

    test "fails to decode private key" do
      assert {:error, "could not decode private_key"} =
               Key.sign_data(
                 "68656C6C6F207261646978",
                 "hello"
               )
    end

    test "catches incorrectly formated private key" do
      assert {:error, "invalid format for private_key"} =
               Key.sign_data(
                 "68656C6C6F207261646978",
                 "ed50"
               )
    end

    test "fails to decode data" do
      assert {:error, "could not decode data"} =
               Key.sign_data(
                 "hello",
                 "ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17"
               )
    end
  end
end
