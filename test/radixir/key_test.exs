defmodule Radixir.KeyTest do
  use ExUnit.Case, async: false
  doctest Radixir.Key

  alias Radixir.Key

  describe "generate/0" do
    test "generates new key + addresses" do
      assert {:ok,
              %{
                mainnet: %{
                  account_address: _mainnet_account_address,
                  node_address: _mainnet_node_address,
                  validator_address: _mainnet_validator_address
                },
                testnet: %{
                  account_address: _testnet_account_address,
                  node_address: _testnet_node_address,
                  validator_address: _testnet_validator_address
                },
                private_key: _private_key,
                public_key: _public_key
              }} = Key.generate()
    end
  end

  describe "generate_mnemonic/0" do
    test "generates new mnemonic" do
      mnemonic = Key.generate_mnemonic()
      assert 24 == mnemonic |> String.split() |> Enum.count()
    end
  end

  describe "from_mnemonic/1" do
    test "derives a keypair and addresses from mnemonic set in env" do
      mnemonic =
        "nurse grid sister metal flock choice system control about mountain sister rapid hundred render shed chicken print cover tape sister zero bronze tattoo stairs"

      Application.put_env(:radixir, Radixir.Config, mnemonic: mnemonic)

      assert {:ok,
              %{
                mainnet: %{
                  account_address:
                    "rdx1qspdkgfmwl656m4nvejgskjrzhp27auwefswhvaztzfamgse2mk8t6gt2apaj",
                  node_address: "rn1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367jtmsh45",
                  validator_address:
                    "rv1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367jng68e2"
                },
                private_key: "9dd06ce00e682e5b6e5e16ced5d90316ddc19a12d0cdeefc223cfd6920aee54b",
                public_key: "02db213b77f54d6eb36664885a4315c2af778eca60ebb3a25893dda21956ec75e9",
                testnet: %{
                  account_address:
                    "tdx1qspdkgfmwl656m4nvejgskjrzhp27auwefswhvaztzfamgse2mk8t6g2xgnd3",
                  node_address: "tn1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367jdzh36r",
                  validator_address:
                    "tv1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367j43apka"
                }
              }} = Radixir.Key.from_mnemonic()
    end

    test "derives a keypair and addresses from mnemonic passed in options with account index and address index of 0" do
      mnemonic =
        "nurse grid sister metal flock choice system control about mountain sister rapid hundred render shed chicken print cover tape sister zero bronze tattoo stairs"

      assert {:ok,
              %{
                mainnet: %{
                  account_address:
                    "rdx1qspdkgfmwl656m4nvejgskjrzhp27auwefswhvaztzfamgse2mk8t6gt2apaj",
                  node_address: "rn1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367jtmsh45",
                  validator_address:
                    "rv1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367jng68e2"
                },
                private_key: "9dd06ce00e682e5b6e5e16ced5d90316ddc19a12d0cdeefc223cfd6920aee54b",
                public_key: "02db213b77f54d6eb36664885a4315c2af778eca60ebb3a25893dda21956ec75e9",
                testnet: %{
                  account_address:
                    "tdx1qspdkgfmwl656m4nvejgskjrzhp27auwefswhvaztzfamgse2mk8t6g2xgnd3",
                  node_address: "tn1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367jdzh36r",
                  validator_address:
                    "tv1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367j43apka"
                }
              }} =
               Radixir.Key.from_mnemonic(mnemonic: mnemonic, account_index: 0, address_index: 0)
    end

    test "derives a keypair and addresses from mnemonic passed in options with account index and address index of 1" do
      mnemonic =
        "nurse grid sister metal flock choice system control about mountain sister rapid hundred render shed chicken print cover tape sister zero bronze tattoo stairs"

      assert {:ok,
              %{
                mainnet: %{
                  account_address:
                    "rdx1qspgkm2k7eg9g0mj6089kjluupnhe8vdcrn067s248kmc6qe0jdvayg9fjvm6",
                  node_address: "rn1q29k64hk2p2r7ukneed5hl8qva7fmrwqum7h5z4fak7xsxtunt8fzdssveg",
                  validator_address:
                    "rv1q29k64hk2p2r7ukneed5hl8qva7fmrwqum7h5z4fak7xsxtunt8fz4r6u4k"
                },
                private_key: "fe7318fe547258f1e21744516a89b82fe586aeb9ade7f3de6a786616af437881",
                public_key: "028b6d56f650543f72d3ce5b4bfce0677c9d8dc0e6fd7a0aa9edbc68197c9ace91",
                testnet: %{
                  account_address:
                    "tdx1qspgkm2k7eg9g0mj6089kjluupnhe8vdcrn067s248kmc6qe0jdvaygy987te",
                  node_address: "tn1q29k64hk2p2r7ukneed5hl8qva7fmrwqum7h5z4fak7xsxtunt8fztfh2kl",
                  validator_address:
                    "tv1q29k64hk2p2r7ukneed5hl8qva7fmrwqum7h5z4fak7xsxtunt8fzn6a66p"
                }
              }} =
               Radixir.Key.from_mnemonic(mnemonic: mnemonic, account_index: 1, address_index: 1)
    end

    test "fails to derive a keypair and addresses because no mnemonic was found" do
      assert {:error, "mnemonic not found in configuration"} = Radixir.Key.from_mnemonic()
    end

    test "fails to derive a keypair and addresses because no configuration was set" do
      Application.delete_env(:radixir, Radixir.Config)
      assert {:error, "no configuration parameters found"} = Radixir.Key.from_mnemonic()
    end

    test "fails to derive a keypair and addresses because non BIP39 mnemonic was given" do
      assert_raise ArgumentError, fn -> Radixir.Key.from_mnemonic(mnemonic: "carl tod") end
    end

    test "fails to derive a keypair and addresses because invalid mnemonic was given" do
      assert_raise FunctionClauseError, fn ->
        Radixir.Key.from_mnemonic(mnemonic: "nurse grid sister")
      end
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

    test "catches private_key having non hexadecimal digits" do
      assert {:error, "private_key must only have hexadecimal digits"} =
               Key.from_private_key("hello radix")
    end

    test "catches private key not being the correct length" do
      assert {:error, "private_key must be 64 characters long"} = Key.from_private_key("ed50")
    end
  end

  describe "address_to_public_key/1" do
    test "converts an address (starts with tdx) to its public key" do
      assert {:ok, "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f"} =
               Key.address_to_public_key(
                 "tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7"
               )
    end

    test "converts an address (starts with rdx) to its public key" do
      assert {:ok, "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f"} =
               Key.address_to_public_key(
                 "rdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmceghq5a"
               )
    end

    test "catches address having non alpha numeric characters" do
      assert {:error, "address must only have alpha numeric characters"} =
               Key.address_to_public_key("hello radix")
    end

    test "catches address not being the correct length" do
      assert {:error, "address must be 65 characters long"} = Key.address_to_public_key("rdxed50")
    end

    test "catches address not starting with rdx or tdx" do
      assert {:error, "address must start with rdx or tdx"} =
               Key.address_to_public_key(
                 "ddx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7"
               )
    end
  end

  describe "public_key_to_addresses/1" do
    test "converts a public key to its addresses" do
      assert %{
               mainnet_address:
                 "rdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmceghq5a",
               testnet_address:
                 "tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7"
             } =
               Key.public_key_to_addresses(
                 "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f"
               )
    end

    test "catches public_key having non hexadecimal digits" do
      assert {:error, "public_key must only have hexadecimal digits"} =
               Key.public_key_to_addresses("hello radix")
    end

    test "catches private key not being the correct length" do
      assert {:error, "public_key must be 66 characters long"} =
               Key.public_key_to_addresses("ed50")
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

    test "catches private_key having non hexadecimal digits" do
      assert {:error, "private_key must only have hexadecimal digits"} =
               Key.private_key_to_secret_integer("hello radix")
    end

    test "catches private key not being the correct length" do
      assert {:error, "private_key must be 64 characters long"} =
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

    test "catches private_key having non hexadecimal digits" do
      assert {:error, "private_key must only have hexadecimal digits"} =
               Key.sign_data(
                 "68656C6C6F207261646978",
                 "hello"
               )
    end

    test "catches private key not being the correct length" do
      assert {:error, "private_key must be 64 characters long"} =
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
