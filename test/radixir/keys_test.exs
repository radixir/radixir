defmodule Radixir.KeysTest do
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
end
