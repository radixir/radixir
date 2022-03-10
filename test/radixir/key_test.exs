defmodule Radixir.KeyTest do
  use ExUnit.Case, async: true
  doctest Radixir.Key

  alias Radixir.Key

  describe "generate/0" do
    test "generates new key + addresses" do
      assert %{
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
             } = Key.generate()
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
              }} = Key.from_mnemonic()
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
              }} = Key.from_mnemonic(mnemonic: mnemonic, account_index: 0, address_index: 0)
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
              }} = Key.from_mnemonic(mnemonic: mnemonic, account_index: 1, address_index: 1)
    end

    test "fails to derive a keypair and addresses because no configuration was set" do
      Application.delete_env(:radixir, Radixir.Config)
      assert {:error, "no configuration parameters found"} = Key.from_mnemonic()
    end

    test "fails to derive a keypair and addresses because non BIP39 mnemonic was given" do
      assert_raise ArgumentError, fn -> Key.from_mnemonic(mnemonic: "carl tod") end
    end

    test "fails to derive a keypair and addresses because invalid mnemonic was given" do
      assert_raise FunctionClauseError, fn ->
        Key.from_mnemonic(mnemonic: "nurse grid sister")
      end
    end
  end

  describe "from_account_extended_private_key/1" do
    test "derives a keypair and addresses from account extended private key" do
      assert {:ok,
              %{
                mainnet: %{
                  account_address:
                    "rdx1qspgw45trvgp9nd7ca9vznrmq0cqy44du60utqmj3f0xp404gx04mwq28puxy",
                  node_address: "rn1q2r4dzcmzqfvm0k8ftq5c7cr7qp9dt0xnlzcxu52tesdta2pnawmsv4kwd6",
                  validator_address:
                    "rv1q2r4dzcmzqfvm0k8ftq5c7cr7qp9dt0xnlzcxu52tesdta2pnawms5xu7py"
                },
                private_key: "f7b9e64ce04a7c6ad62520e14d787b3109e9b3317483da0bc970d4d6e59e866a",
                public_key: "0287568b1b1012cdbec74ac14c7b03f00256ade69fc583728a5e60d5f5419f5db8",
                testnet: %{
                  account_address:
                    "tdx1qspgw45trvgp9nd7ca9vznrmq0cqy44du60utqmj3f0xp404gx04mwqtt5wk8",
                  node_address: "tn1q2r4dzcmzqfvm0k8ftq5c7cr7qp9dt0xnlzcxu52tesdta2pnawms2v3gzd",
                  validator_address:
                    "tv1q2r4dzcmzqfvm0k8ftq5c7cr7qp9dt0xnlzcxu52tesdta2pnawmsjlmcwn"
                }
              }} =
               Key.from_account_extended_private_key(
                 "xprv9xvGWitXHhPc4R9opoQJrA5xfvUsXzdS9gEsEE8AVk1rbdHxcjngXHJ971JC7ensJS6u5XT7wNo23smXy1KfSmmffZWMyCDsfQQaQ2QPr5z",
                 1
               )
    end

    test "derives a keypair and addresses from account extended private key and checks against from_mnemonic" do
      assert Key.from_mnemonic(
               mnemonic:
                 "nurse grid sister metal flock choice system control about mountain sister rapid hundred render shed chicken print cover tape sister zero bronze tattoo stairs",
               account_index: 1,
               address_index: 1
             ) ==
               Key.from_account_extended_private_key(
                 "xprv9xvGWitXHhPc6cwCZRpSBxnNpGovAAtNwHQJ2rc5Gmxt4PSZR9gZvX3qA614mU9EyZaFxcHnFWmdZAKFu1WiritR9UMGXL5drySpT1pRSFz",
                 1
               )
    end

    test "fails to derive a keypair and addresses from account extended private key due to bad key with MatchError" do
      assert_raise MatchError, fn ->
        Key.from_account_extended_private_key(
          "xprv9xvGWitXHhPc4R9opoQJrA5xfvUsXzdS9gEsEE8AVk1rbdHxcjngXHJ971JC7ensJS6u5XT7wNo23smXy1KfSmmffZWMyCDsfQQaQ2QPr5"
        )
      end
    end

    test "fails to derive a keypair and addresses from account extended private key due to bad key with FunctionClauseError" do
      assert_raise FunctionClauseError, fn ->
        Key.from_account_extended_private_key("asdfasdf")
      end
    end

    test "fails to derive a keypair and addresses from account extended private key due to bad key with ArgumentError" do
      assert_raise ArgumentError, fn ->
        Key.from_account_extended_private_key("xpubasdfasd")
      end
    end
  end

  describe "from_private_key/1" do
    test "derives keypair and addresses from private key" do
      assert {:ok,
              %{
                mainnet: %{
                  account_address:
                    "rdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmceghq5a",
                  node_address: "rn1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7mctqsv",
                  validator_address:
                    "rv1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7rtpsuj"
                },
                private_key: "ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17",
                public_key: "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f",
                testnet: %{
                  account_address:
                    "tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7",
                  node_address: "tn1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7apvxlm",
                  validator_address:
                    "tv1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx79jxkn9"
                }
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

  describe "derive_account_extended_keys_from_mnemonic/1" do
    test "derives account extended keys from mnemonic" do
      assert %{
               account_extended_private_key:
                 "xprv9xvGWitXHhPc6cwCZRpSBxnNpGovAAtNwHQJ2rc5Gmxt4PSZR9gZvX3qA614mU9EyZaFxcHnFWmdZAKFu1WiritR9UMGXL5drySpT1pRSFz",
               account_extended_public_key:
                 "xpub6BucvERR84wuK71ffTMSZ6j7NJeQZdcEJWKtqF1gq7VrwBmhxgzpUKNK1P6jR2iWRMUagy94y9XK3wG3hUtAoVLVyQ3nSwA9pzepBCb2rRK"
             } =
               Key.derive_account_extended_keys_from_mnemonic(
                 mnemonic:
                   "nurse grid sister metal flock choice system control about mountain sister rapid hundred render shed chicken print cover tape sister zero bronze tattoo stairs",
                 account_index: 1
               )
    end

    test "fails derives account extended keys from mnemonic because no configuration was set" do
      Application.delete_env(:radixir, Radixir.Config)

      assert {:error, "no configuration parameters found"} =
               Key.derive_account_extended_keys_from_mnemonic()
    end

    test "fails derives account extended keys from mnemonic because non BIP39 mnemonic was given" do
      assert_raise ArgumentError, fn ->
        Key.derive_account_extended_keys_from_mnemonic(mnemonic: "carl tod")
      end
    end

    test "fails derives account extended keys from mnemonic because invalid mnemonic was given" do
      assert_raise FunctionClauseError, fn ->
        Key.derive_account_extended_keys_from_mnemonic(mnemonic: "nurse grid sister")
      end
    end
  end

  describe "account_extended_public_key_to_addresses/2" do
    test "Converts account extended public key to addresses" do
      assert {:ok,
              %{
                mainnet: %{
                  account_address:
                    "rdx1qspr0yphjarred20cr9vyy6h8ky60wun5t8z7g3lm3z25klf4yulmwgmwg5c8",
                  node_address: "rn1qgmeqduhgc7t2n7qetppx4ea3xnmhyazechjy07ugj49h6df887mjqymm42",
                  validator_address:
                    "rv1qgmeqduhgc7t2n7qetppx4ea3xnmhyazechjy07ugj49h6df887mjch3te5"
                },
                testnet: %{
                  account_address:
                    "tdx1qspr0yphjarred20cr9vyy6h8ky60wun5t8z7g3lm3z25klf4yulmwg6zaxgy",
                  node_address: "tn1qgmeqduhgc7t2n7qetppx4ea3xnmhyazechjy07ugj49h6df887mjxaua6a",
                  validator_address:
                    "tv1qgmeqduhgc7t2n7qetppx4ea3xnmhyazechjy07ugj49h6df887mj7wkdkr"
                }
              }} =
               Key.account_extended_public_key_to_addresses(
                 "xpub6BucvERR84wuK71ffTMSZ6j7NJeQZdcEJWKtqF1gq7VrwBmhxgzpUKNK1P6jR2iWRMUagy94y9XK3wG3hUtAoVLVyQ3nSwA9pzepBCb2rRK",
                 1
               )
    end

    test "fails to converts account extended public key to addresses due to bad key with MatchError" do
      assert_raise MatchError, fn ->
        Key.account_extended_public_key_to_addresses(
          "xpub6BucvERR84wuK71ffTMSZ6j7NJeQZdcEJWKtqF1gq7VrwBmhxgzpUKNK1P6jR2iWRMUagy94y9XK3wG3hUtAoVLVyQ3nSwA9pzepBCb2rR"
        )
      end
    end

    test "fails to converts account extended public key to addresses due to bad key with FunctionClauseError" do
      assert_raise FunctionClauseError, fn ->
        Key.account_extended_public_key_to_addresses("asdfasdf")
      end
    end
  end

  describe "public_key_to_addresses/1" do
    test "converts a public key to its addresses" do
      assert {:ok,
              %{
                mainnet: %{
                  account_address:
                    "rdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmceghq5a",
                  node_address: "rn1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7mctqsv",
                  validator_address:
                    "rv1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7rtpsuj"
                },
                testnet: %{
                  account_address:
                    "tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7",
                  node_address: "tn1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7apvxlm",
                  validator_address:
                    "tv1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx79jxkn9"
                }
              }} =
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

    test "converts an address (starts with rv) to its public key" do
      assert {:ok, "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f"} =
               Key.address_to_public_key(
                 "rv1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7rtpsuj"
               )
    end

    test "converts an address (starts with tv) to its public key" do
      assert {:ok, "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f"} =
               Key.address_to_public_key(
                 "tv1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx79jxkn9"
               )
    end

    test "converts an address (starts with rn) to its public key" do
      assert {:ok, "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f"} =
               Key.address_to_public_key(
                 "rn1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7mctqsv"
               )
    end

    test "converts an address (starts with tn) to its public key" do
      assert {:ok, "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f"} =
               Key.address_to_public_key(
                 "tn1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7apvxlm"
               )
    end

    test "catches address having non alpha numeric characters" do
      assert {:error, "address must only have alpha numeric characters"} =
               Key.address_to_public_key("hello radix")
    end

    test "catches address not being the correct length - rdx" do
      assert {:error, "account address must be 65 characters long"} =
               Key.address_to_public_key("rdxed50")
    end

    test "catches address not being the correct length - tdx" do
      assert {:error, "account address must be 65 characters long"} =
               Key.address_to_public_key("tdxed50")
    end

    test "catches address not being the correct length - rn" do
      assert {:error, "node address must be 62 characters long"} =
               Key.address_to_public_key("rned50")
    end

    test "catches address not being the correct length - tn" do
      assert {:error, "node address must be 62 characters long"} =
               Key.address_to_public_key("tned50")
    end

    test "catches address not being the correct length - rv" do
      assert {:error, "validator address must be 62 characters long"} =
               Key.address_to_public_key("rved50")
    end

    test "catches address not being the correct length - tv" do
      assert {:error, "validator address must be 62 characters long"} =
               Key.address_to_public_key("tved50")
    end

    test "catches address not starting with rdx, tdx, rv, tv, rn or tn" do
      assert {:error, "address must start with rdx, tdx, rv, tv, rn or tn"} =
               Key.address_to_public_key(
                 "ddx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7"
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

  describe "derive_token_rri/2" do
    test "derives mainnet and testnet token rri from public_key and symbol" do
      assert {:ok,
              %{
                mainnet: "gok_rr1qdjusppk2dqe2r08xlnlauuaedn9rtuttz2c6g76jq3qee68dq",
                testnet: "gok_tr1qdjusppk2dqe2r08xlnlauuaedn9rtuttz2c6g76jq3qezz2ds"
              }} =
               Key.derive_token_rri(
                 "02690937690ffb9d7ae8b67af05efc03a5a9f7e53933de80f92ce763a5554a1fa3",
                 "gok"
               )
    end

    test "catches public_key having non hexadecimal digits" do
      assert {:error, "public_key must only have hexadecimal digits"} =
               Key.derive_token_rri("hello radix", "gok")
    end

    test "catches private key not being the correct length" do
      assert {:error, "public_key must be 66 characters long"} =
               Key.derive_token_rri("ed50", "gok")
    end
  end
end
