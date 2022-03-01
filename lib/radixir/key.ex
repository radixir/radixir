defmodule Radixir.Key do
  @moduledoc """
  Handles all things to do with public/private keys and radix addresses.
  """

  alias BlockKeys.Encoding
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
  @type index :: integer
  @type options :: keyword

  @doc """
  Generates a new keypair and addresses.
  """
  @spec generate() :: map
  def generate(), do: Curvy.generate_key() |> format()

  @doc """
  Generates a new mnemonic.
  """
  @spec generate_mnemonic() :: String.t()
  def generate_mnemonic(), do: BlockKeys.Mnemonic.generate_phrase()

  @doc """
  Generates a keypair and addresses from mnemonic.

  ## Parameters
    - `options`: Keyword list that contains
      - `mnemonic` (optional, string): If `mnemonic` is not in `options` then the mnemonic set in the configs will be used.
      - `account_index` (optional, integer): If `account_index` is not in `options` then an `account_index` of 0 will be used.
      - `address_index` (optional, integer): If `address_index` is not in `options` then an `address_index` of 0 will be used.
  """
  @spec generate_from_mnemonic(options) :: {:ok, map} | {:error, error_message}
  def generate_from_mnemonic(options \\ []) do
    with {:ok, mnemonic} <- Util.get_mnemonic_from_options(options),
         account_index <- Keyword.get(options, :account_index, 0),
         address_index <- Keyword.get(options, :address_index, 0) do
      BlockKeys.from_mnemonic(mnemonic)
      |> BlockKeys.CKD.derive("m/44'/1022'/#{account_index}'/0/#{address_index}")
      |> Encoding.decode_extended_key()
      |> Map.fetch!(:key)
      |> Util.encode16()
      |> String.replace_prefix("00", "")
      |> from_private_key()
    end
  end

  @doc """
  Generates account extended private key and account extended public key from mnemonic.

  ## Parameters
    - `options`: Keyword list that contains
      - `mnemonic` (optional, string): If `mnemonic` is not in `options` then the mnemonic set in the configs will be used.
      - `account_index` (optional, integer): If `account_index` is not in `options` then an `account_index` of 0 will be used.
  """
  @spec get_account_extended_keys_from_mnemonic(options) :: {:ok, map} | {:error, error_message}
  def get_account_extended_keys_from_mnemonic(options \\ []) do
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
  Generates a keypair and addresses from account extended private key.

  ## Parameters
    - `account_extended_private_key`: Account extended private key.
    - `index`: Path index.
  """
  @spec from_account_extended_private_key(account_extended_private_key, index) ::
          {:ok, map} | {:error, error_message}
  def from_account_extended_private_key(account_extended_private_key, index \\ 0) do
    BlockKeys.CKD.derive(account_extended_private_key, "m/0/#{index}")
    |> Encoding.decode_extended_key()
    |> Map.fetch!(:key)
    |> Util.encode16()
    |> String.replace_prefix("00", "")
    |> from_private_key()
  end

  @doc """
  Generates addresses from master public key.

  ## Parameters
    - `account_extended_public_key`: Master public key.
    - `index`: Path index.
  """
  @spec account_extended_public_key_to_addresses(account_extended_public_key, index) ::
          {:ok, map} | {:error, error_message}
  def account_extended_public_key_to_addresses(account_extended_public_key, index \\ 0) do
    BlockKeys.CKD.derive(account_extended_public_key, "M/0/#{index}")
    |> Encoding.decode_extended_key()
    |> Map.fetch!(:key)
    |> Util.encode16()
    |> public_key_to_addresses()
  end

  @doc """
  Converts `private_key` to its keypair and addresses.

  ## Parameters
    - `private_key`: Hex encoded private key.

  ## Examples
      iex> Radixir.Key.from_private_key("ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17")
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
        },
        private_key: "ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17",
        public_key: "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f"
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
  Generates mainnet and testnet token rri from `public_key` and `symbol`.

  ## Parameters
    - `public_key`: Hex encoded public key.
    - `synbol`: Token symbol.

  ## Examples
      iex> Radixir.Key.generate_token_rri("02690937690ffb9d7ae8b67af05efc03a5a9f7e53933de80f92ce763a5554a1fa3","gok")
      %{
        mainnet: "gok_rr1qdjusppk2dqe2r08xlnlauuaedn9rtuttz2c6g76jq3qee68dq",
        testnet: "gok_tr1qdjusppk2dqe2r08xlnlauuaedn9rtuttz2c6g76jq3qezz2ds"
      }
  """
  @spec generate_token_rri(public_key, symbol) :: {:ok, map()} | {:error, error_message}
  def generate_token_rri(public_key, symbol) do
    with public_key <- String.downcase(public_key),
         symbol <- String.downcase(symbol),
         {:ok, public_key} <- validate_public_key(public_key),
         {:ok, public_key} <- Util.decode16(public_key, "public_key") do
      result =
        (public_key <> symbol)
        |> Util.hash()
        |> Util.hash()
        |> String.slice(6..31)

      data = <<3>> <> result

      %{
        mainnet: Bech32.encode(symbol <> "_rr", data),
        testnet: Bech32.encode(symbol <> "_tr", data)
      }
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
    case String.match?(address, ~r/^rdx|tdx|rv|tv|rn|tn/) do
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
