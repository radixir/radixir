defmodule Radixir.Key do
  @moduledoc """
  Handles all things to do with mnemonics, keys and addresses.
  """

  alias BlockKeys.Encoding
  alias Radixir.Bech32
  alias Radixir.Util

  @type private_key :: String.t()
  @type public_key :: String.t()
  @type address :: String.t()
  @type addresses :: map
  @type data :: String.t()
  @type symbol :: String.t()
  @type signed_data :: Stiring.t()
  @type error_message :: String.t()
  @type account_extended_private_key :: String.t()
  @type account_extended_public_key :: String.t()
  @type address_index :: integer
  @type options :: keyword

  @doc """
  Generates a new keypair and addresses.

  ## Examples

      Radixir.Key.generate()
      %{
        mainnet: %{
          account_address: "rdx1qsp6sg72yg8hpznc60hsy4jmjqyknst2sfswu5h9xv5knyntemgvnesrl9mr9",
          node_address: "rn1qw5z8j3zpacg57xnaup9vkusp95uz65zvrh99efn995ey67w6ry7vqje79j",
          validator_address: "rv1qw5z8j3zpacg57xnaup9vkusp95uz65zvrh99efn995ey67w6ry7vcpnwfv"
        },
        private_key: "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34",
        public_key: "03a823ca220f708a78d3ef02565b900969c16a8260ee52e5332969926bced0c9e6",
        testnet: %{
          account_address: "tdx1qsp6sg72yg8hpznc60hsy4jmjqyknst2sfswu5h9xv5knyntemgvnesznsfnx",
          node_address: "tn1qw5z8j3zpacg57xnaup9vkusp95uz65zvrh99efn995ey67w6ry7vxt7c29",
          validator_address: "tv1qw5z8j3zpacg57xnaup9vkusp95uz65zvrh99efn995ey67w6ry7v7c5gxm"
        }
      }
  """
  @spec generate() :: map
  def generate(), do: Curvy.generate_key() |> format()

  @doc """
  Generates a new mnemonic.

  ## Examples

      Radixir.Key.generate_mnemonic()
      "rival glimpse kick start glide fix school cook adult pulse property chef garden hobby attract market market broom position truly shell diagram throw invite"
  """
  @spec generate_mnemonic() :: String.t()
  def generate_mnemonic(), do: BlockKeys.Mnemonic.generate_phrase()

  @doc """
  Derives a keypair and addresses from mnemonic.

  ## Parameters
    - `options`: Keyword list that contains
      - `mnemonic` (optional, string): If `mnemonic` is not in `options` then the mnemonic set in the configs will be used.
      - `account_index` (optional, integer): If `account_index` is not in `options` then an `account_index` of 0 will be used.
      - `address_index` (optional, integer): If `address_index` is not in `options` then an `address_index` of 0 will be used.

  ## Examples

      iex> Radixir.Key.from_mnemonic(mnemonic: "nurse grid sister metal flock choice system control about mountain sister rapid hundred render shed chicken print cover tape sister zero bronze tattoo stairs", account_index: 0, address_index: 0)
      {:ok,
      %{
        mainnet: %{
          account_address: "rdx1qspdkgfmwl656m4nvejgskjrzhp27auwefswhvaztzfamgse2mk8t6gt2apaj",
          node_address: "rn1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367jtmsh45",
          validator_address: "rv1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367jng68e2"
        },
        private_key: "9dd06ce00e682e5b6e5e16ced5d90316ddc19a12d0cdeefc223cfd6920aee54b",
        public_key: "02db213b77f54d6eb36664885a4315c2af778eca60ebb3a25893dda21956ec75e9",
        testnet: %{
          account_address: "tdx1qspdkgfmwl656m4nvejgskjrzhp27auwefswhvaztzfamgse2mk8t6g2xgnd3",
          node_address: "tn1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367jdzh36r",
          validator_address: "tv1qtdjzwmh74xkavmxvjy95sc4c2hh0rk2vr4m8gjcj0w6yx2ka367j43apka"
        }
      }}
  """
  @spec from_mnemonic(options) :: {:ok, map} | {:error, error_message}
  def from_mnemonic(options \\ []) do
    with {:ok, mnemonic} <- Util.get_mnemonic_from_options(options),
         account_index <- Keyword.get(options, :account_index, 0),
         address_index <- Keyword.get(options, :address_index, 0) do
      BlockKeys.from_mnemonic(mnemonic)
      |> BlockKeys.CKD.derive("m/44'/1022'/#{account_index}'/0/#{address_index}'")
      |> Encoding.decode_extended_key()
      |> Map.fetch!(:key)
      |> Util.encode16()
      |> String.replace_prefix("00", "")
      |> from_private_key()
    end
  end

  @doc """
  Derives a keypair and addresses from account extended private key.

  ## Parameters
    - `account_extended_private_key`: Account extended private key.
    - `address_index`: Address index.

  ## Examples

      iex> Radixir.Key.from_account_extended_private_key("xprv9xvGWitXHhPc4R9opoQJrA5xfvUsXzdS9gEsEE8AVk1rbdHxcjngXHJ971JC7ensJS6u5XT7wNo23smXy1KfSmmffZWMyCDsfQQaQ2QPr5z", 1)
      {:ok,
      %{
        mainnet: %{
          account_address: "rdx1qspgw45trvgp9nd7ca9vznrmq0cqy44du60utqmj3f0xp404gx04mwq28puxy",
          node_address: "rn1q2r4dzcmzqfvm0k8ftq5c7cr7qp9dt0xnlzcxu52tesdta2pnawmsv4kwd6",
          validator_address: "rv1q2r4dzcmzqfvm0k8ftq5c7cr7qp9dt0xnlzcxu52tesdta2pnawms5xu7py"
        },
        private_key: "f7b9e64ce04a7c6ad62520e14d787b3109e9b3317483da0bc970d4d6e59e866a",
        public_key: "0287568b1b1012cdbec74ac14c7b03f00256ade69fc583728a5e60d5f5419f5db8",
        testnet: %{
          account_address: "tdx1qspgw45trvgp9nd7ca9vznrmq0cqy44du60utqmj3f0xp404gx04mwqtt5wk8",
          node_address: "tn1q2r4dzcmzqfvm0k8ftq5c7cr7qp9dt0xnlzcxu52tesdta2pnawms2v3gzd",
          validator_address: "tv1q2r4dzcmzqfvm0k8ftq5c7cr7qp9dt0xnlzcxu52tesdta2pnawmsjlmcwn"
        }
      }}
  """
  @spec from_account_extended_private_key(account_extended_private_key, address_index) ::
          {:ok, map} | {:error, error_message}
  def from_account_extended_private_key(account_extended_private_key, address_index \\ 0) do
    BlockKeys.CKD.derive(account_extended_private_key, "m/0/#{address_index}'")
    |> Encoding.decode_extended_key()
    |> Map.fetch!(:key)
    |> Util.encode16()
    |> String.replace_prefix("00", "")
    |> from_private_key()
  end

  @doc """
  Derives keypair and addresses from private key.

  ## Parameters
    - `private_key`: Private key.

  ## Examples

      iex> Radixir.Key.from_private_key("ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17")
      {:ok,
      %{
        mainnet: %{
          account_address: "rdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmceghq5a",
          node_address: "rn1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7mctqsv",
          validator_address: "rv1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7rtpsuj"
        },
        private_key: "ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17",
        public_key: "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f",
        testnet: %{
          account_address: "tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7",
          node_address: "tn1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7apvxlm",
          validator_address: "tv1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx79jxkn9"
        }
      }}
  """
  @spec from_private_key(private_key) :: {:ok, map} | {:error, error_message}
  def from_private_key(private_key) do
    with private_key <- String.downcase(private_key),
         {:ok, private_key} <- validate_private_key(private_key),
         {:ok, keypair} <- private_key_to_keypair(private_key) do
      {:ok, format(keypair)}
    end
  end

  @doc """
  Derives account extended private key and account extended public key from mnemonic.

  ## Parameters
    - `options`: Keyword list that contains
      - `mnemonic` (optional, string): If `mnemonic` is not in `options` then the mnemonic set in the configs will be used.
      - `account_index` (optional, integer): If `account_index` is not in `options` then an `account_index` of 0 will be used.

  ## Examples

      iex> Radixir.Key.derive_account_extended_keys_from_mnemonic(mnemonic: "nurse grid sister metal flock choice system control about mountain sister rapid hundred render shed chicken print cover tape sister zero bronze tattoo stairs", account_index: 1)
      %{
        account_extended_private_key: "xprv9xvGWitXHhPc6cwCZRpSBxnNpGovAAtNwHQJ2rc5Gmxt4PSZR9gZvX3qA614mU9EyZaFxcHnFWmdZAKFu1WiritR9UMGXL5drySpT1pRSFz",
        account_extended_public_key: "xpub6BucvERR84wuK71ffTMSZ6j7NJeQZdcEJWKtqF1gq7VrwBmhxgzpUKNK1P6jR2iWRMUagy94y9XK3wG3hUtAoVLVyQ3nSwA9pzepBCb2rRK"
      }
  """
  @spec derive_account_extended_keys_from_mnemonic(options) ::
          {:ok, map} | {:error, error_message}
  def derive_account_extended_keys_from_mnemonic(options \\ []) do
    with {:ok, mnemonic} <- Util.get_mnemonic_from_options(options),
         account_index <- Keyword.get(options, :account_index, 0) do
      root_key = BlockKeys.from_mnemonic(mnemonic)

      %{
        account_extended_private_key:
          BlockKeys.CKD.derive(root_key, "m/44'/1022'/#{account_index}'"),
        account_extended_public_key:
          BlockKeys.CKD.derive(root_key, "M/44'/1022'/#{account_index}'")
      }
    end
  end

  @doc """
  Generates addresses from master public key.

  ## Parameters
    - `account_extended_public_key`: Master public key.
    - `address_index`: Address index.

  ## Examples

      iex> Radixir.Key.account_extended_public_key_to_addresses("xpub6BucvERR84wuK71ffTMSZ6j7NJeQZdcEJWKtqF1gq7VrwBmhxgzpUKNK1P6jR2iWRMUagy94y9XK3wG3hUtAoVLVyQ3nSwA9pzepBCb2rRK", 1)
      {:ok,
      %{
        mainnet: %{
          account_address: "rdx1qspr0yphjarred20cr9vyy6h8ky60wun5t8z7g3lm3z25klf4yulmwgmwg5c8",
          node_address: "rn1qgmeqduhgc7t2n7qetppx4ea3xnmhyazechjy07ugj49h6df887mjqymm42",
          validator_address: "rv1qgmeqduhgc7t2n7qetppx4ea3xnmhyazechjy07ugj49h6df887mjch3te5"
        },
        testnet: %{
          account_address: "tdx1qspr0yphjarred20cr9vyy6h8ky60wun5t8z7g3lm3z25klf4yulmwg6zaxgy",
          node_address: "tn1qgmeqduhgc7t2n7qetppx4ea3xnmhyazechjy07ugj49h6df887mjxaua6a",
          validator_address: "tv1qgmeqduhgc7t2n7qetppx4ea3xnmhyazechjy07ugj49h6df887mj7wkdkr"
        }
      }}
  """
  @spec account_extended_public_key_to_addresses(account_extended_public_key, address_index) ::
          {:ok, map} | {:error, error_message}
  def account_extended_public_key_to_addresses(account_extended_public_key, address_index \\ 0) do
    BlockKeys.CKD.derive(account_extended_public_key, "M/0/#{address_index}")
    |> Encoding.decode_extended_key()
    |> Map.fetch!(:key)
    |> Util.encode16()
    |> public_key_to_addresses()
  end

  @doc """
  Converts `public_key` to its addresses.

  ## Parameters
    - `public_key`: Hex encoded public key.

  ## Examples

      iex> Radixir.Key.public_key_to_addresses("032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f")
      {:ok,
      %{
        mainnet: %{
          account_address: "rdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmceghq5a",
          node_address: "rn1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7mctqsv",
          validator_address: "rv1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7rtpsuj"
        },
        testnet: %{
          account_address: "tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7",
          node_address: "tn1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx7apvxlm",
          validator_address: "tv1qvhe4nxylxgxmlazzt2ua78383l67cqzgthygygafhhyljhe0pjx79jxkn9"
        }
      }}
  """
  @spec public_key_to_addresses(public_key) :: {:ok, addresses} | {:error, error_message}
  def public_key_to_addresses(public_key) do
    with public_key <- String.downcase(public_key),
         {:ok, public_key} <- validate_public_key(public_key),
         {:ok, public_key} <- Util.decode16(public_key, "public_key") do
      {:ok, pubkey_to_addrs(public_key)}
    end
  end

  @doc """
  Converts `address` to its public key.

  ## Parameters
    - `address`: Radix address.

  ## Examples

      iex> Radixir.Key.address_to_public_key("tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7")
      {:ok,
        "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f"
      }
  """
  @spec address_to_public_key(address) :: {:ok, public_key} | {:error, atom()}
  def address_to_public_key(address) do
    with address <- String.downcase(address),
         {:ok, address} <- validate_address(address),
         {:ok, public_key_bytes} <- addr_to_pubkey(address) do
      {:ok, Util.encode16(public_key_bytes)}
    end
  end

  @doc """
  Converts `private_key` to its secret integer.

  ## Parameters
    - `private_key`: Hex encoded private key.

  ## Examples

      iex> Radixir.Key.private_key_to_secret_integer("ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17")
      {:ok,
        107340927595134471984420820489673630767605194678966104711498635548873815202327
      }
  """
  @spec private_key_to_secret_integer(private_key) ::
          {:ok, non_neg_integer} | {:error, error_message}
  def private_key_to_secret_integer(private_key) do
    with private_key <- String.downcase(private_key),
         {:ok, private_key} <- validate_private_key(private_key),
         {:ok, keypair} <- private_key_to_keypair(private_key) do
      {:ok, :binary.decode_unsigned(keypair.privkey)}
    end
  end

  @doc """
  Signs `data` with `private_key`.

  ## Parameters
    - `data`: Hex encoded data to be signed.
    - `private_key`: Hex encoded private key.

  ## Examples

      iex> Radixir.Key.sign_data("68656C6C6F207261646978","ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17")
      {:ok,
        "304402206f2c0f3a70c23879a44a2910f9b060e59d5b96e350605fdbee2a7a265ca503c302201043a8a957353744608c86824c286034e6166be475c7c096527a225cbdf90d0a"
      }
  """
  @spec sign_data(data, private_key) :: {:ok, signed_data} | {:error, error_message}
  def sign_data(data, private_key) do
    with private_key <- String.downcase(private_key),
         {:ok, private_key} <- validate_private_key(private_key),
         {:ok, keypair} <- private_key_to_keypair(private_key),
         {:ok, data} <- Util.decode16(data, "data") do
      {:ok, Curvy.sign(data, Curvy.Key.to_privkey(keypair), encoding: :hex, hash: :none)}
    end
  end

  @doc """
  Derives mainnet and testnet token rri from `public_key` and `symbol`.

  ## Parameters
    - `public_key`: Hex encoded public key.
    - `synbol`: Token symbol.

  ## Examples

      iex> Radixir.Key.derive_token_rri("02690937690ffb9d7ae8b67af05efc03a5a9f7e53933de80f92ce763a5554a1fa3","gok")
      {:ok,
      %{
        mainnet: "gok_rr1qdjusppk2dqe2r08xlnlauuaedn9rtuttz2c6g76jq3qee68dq",
        testnet: "gok_tr1qdjusppk2dqe2r08xlnlauuaedn9rtuttz2c6g76jq3qezz2ds"
      }}
  """
  @spec derive_token_rri(public_key, symbol) :: {:ok, map} | {:error, error_message}
  def derive_token_rri(public_key, symbol) do
    with public_key <- String.downcase(public_key),
         symbol <- String.downcase(symbol),
         {:ok, _} <- public_key_to_addresses(public_key),
         {:ok, public_key} <- Util.decode16(public_key, "public_key") do
      result =
        (public_key <> symbol)
        |> Util.hash()
        |> Util.hash()
        |> String.slice(6..31)

      data = <<3>> <> result

      {:ok,
       %{
         mainnet: Bech32.encode(symbol <> "_rr", data),
         testnet: Bech32.encode(symbol <> "_tr", data)
       }}
    end
  end

  defp check_private_key_size(<<private_key_bytes::binary-size(32)>>),
    do: {:ok, private_key_bytes}

  defp check_private_key_size(_), do: {:error, "invalid format for private_key"}

  defp private_key_to_keypair(private_key) do
    with {:ok, private_key} <- Util.decode16(private_key, "private_key"),
         {:ok, private_key} <- check_private_key_size(private_key) do
      {:ok, Curvy.Key.from_privkey(private_key)}
    end
  end

  defp format(keypair) do
    public_key = Curvy.Key.to_pubkey(keypair)
    addresses = pubkey_to_addrs(public_key)
    public_key = Util.encode16(public_key)

    private_key =
      keypair
      |> Curvy.Key.to_privkey()
      |> Util.encode16()

    %{
      public_key: public_key,
      private_key: private_key
    }
    |> Map.merge(addresses)
  end

  defp pubkey_to_addrs(public_key) do
    %{
      mainnet: %{
        account_address: Bech32.encode("rdx", <<4>> <> public_key),
        validator_address: Bech32.encode("rv", public_key),
        node_address: Bech32.encode("rn", public_key)
      },
      testnet: %{
        account_address: Bech32.encode("tdx", <<4>> <> public_key),
        validator_address: Bech32.encode("tv", public_key),
        node_address: Bech32.encode("tn", public_key)
      }
    }
  end

  @doc false
  def validate_public_key(public_key) do
    with {:ok, public_key} <- only_has_hex(public_key, "public_key"),
         {:ok, public_key} <- expected_length(public_key, 66, "public_key") do
      {:ok, public_key}
    end
  end

  @doc false
  def validate_private_key(private_key) do
    with {:ok, private_key} <- only_has_hex(private_key, "private_key"),
         {:ok, private_key} <- expected_length(private_key, 64, "private_key") do
      {:ok, private_key}
    end
  end

  @doc false
  def validate_address(address) do
    with {:ok, address} <- only_has_alpha_num(address),
         {:ok, address} <- valid_address_prefix(address),
         {:ok, address} <- valid_address_length(address) do
      {:ok, address}
    end
  end

  defp addr_to_pubkey("rdx" <> _rest = address) do
    with {:ok, _hrp, <<4>> <> public_key_bytes} <- Bech32.decode(address) do
      {:ok, public_key_bytes}
    end
  end

  defp addr_to_pubkey("tdx" <> _rest = address) do
    with {:ok, _hrp, <<4>> <> public_key_bytes} <- Bech32.decode(address) do
      {:ok, public_key_bytes}
    end
  end

  defp addr_to_pubkey(address) do
    with {:ok, _hrp, public_key_bytes} <- Bech32.decode(address) do
      {:ok, public_key_bytes}
    end
  end

  defp only_has_alpha_num(value) do
    case String.match?(value, ~r/^[[:alnum:]]+$/) do
      true ->
        {:ok, value}

      false ->
        {:error, "address must only have alpha numeric characters"}
    end
  end

  defp only_has_hex(value, type) do
    case String.match?(value, ~r/^[[:xdigit:]]+$/) do
      true ->
        {:ok, value}

      false ->
        {:error, "#{type} must only have hexadecimal digits"}
    end
  end

  defp valid_address_prefix(address) do
    case String.match?(address, ~r/^(rdx|tdx|rv|tv|rn|tn)/) do
      true ->
        {:ok, address}

      false ->
        {:error, "address must start with rdx, tdx, rv, tv, rn or tn"}
    end
  end

  defp valid_address_length("rv" <> _rest = address) do
    expected_length(address, 62, "validator address")
  end

  defp valid_address_length("tv" <> _rest = address) do
    expected_length(address, 62, "validator address")
  end

  defp valid_address_length("rn" <> _rest = address) do
    expected_length(address, 62, "node address")
  end

  defp valid_address_length("tn" <> _rest = address) do
    expected_length(address, 62, "node address")
  end

  defp valid_address_length("rdx" <> _rest = address) do
    expected_length(address, 65, "account address")
  end

  defp valid_address_length("tdx" <> _rest = address) do
    expected_length(address, 65, "account address")
  end

  defp expected_length(value, length, type) do
    if String.length(value) == length do
      {:ok, value}
    else
      {:error, "#{type} must be #{length} characters long"}
    end
  end
end
