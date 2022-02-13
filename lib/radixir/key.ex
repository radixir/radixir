defmodule Radixir.Key do
  @moduledoc """
  Handles all things to do with public/private keys and radix addresses.
  """

  alias Radixir.Bech32
  alias Radixir.Util

  @doc """
  Generates a new key + addresses.
  """
  def generate(), do: Curvy.generate_key() |> format_keys()

  @doc """
  Converts a private key to a key + addresses.

  ## Parameters
    - `private_key`: Hex encoded private key.

  ## Examples

      iex> Radixir.Key.from_private_key("ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17")
      {:ok,
        %{
          mainnet_address: "rdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmceghq5a",
          private_key: "ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17",
          public_key: "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f",
          testnet_address: "tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7"
        }
      }
  """
  def from_private_key(private_key) do
    with {:ok, keypair} <- private_key_to_keypair(private_key) do
      {:ok, format_keys(keypair)}
    end
  end

  @doc """
  Converts an address to its public key.

  ## Parameters
    - `address`: Radix address.

  ## Examples

      iex> Radixir.Key.address_to_public_key("tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7")
      {:ok, "032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f"}
  """
  def address_to_public_key(address) do
    with {:ok, _hrp, <<4>> <> public_key_bytes} <- Bech32.decode(address) do
      {:ok, Util.encode16(public_key_bytes)}
    end
  end

  @doc """
  Converts an address to its public key.

  ## Parameters
    - `public_key`: Hex encoded public key.

  ## Examples

      iex> Radixir.Key.public_key_to_addresses("032f9accc4f9906dffa212d5cef8f13c7faf600242ee44111d4dee4fcaf978646f")
      %{
        mainnet_address: "rdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmceghq5a",
        testnet_address: "tdx1qspjlxkvcnueqm0l5gfdtnhc7y78ltmqqfpwu3q3r4x7un72l9uxgmccyzjy7"
      }
  """
  def public_key_to_addresses(public_key) do
    with {:ok, public_key} <- Util.decode16(public_key, "public_key") do
      {mainnet_address, testnet_address} = pubkey_to_addrs(public_key)

      %{
        mainnet_address: mainnet_address,
        testnet_address: testnet_address
      }
    end
  end

  @doc """
  Converts a private key to its secret integer.

  ## Parameters
    - `private_key`: Hex encoded private key.

  ## Examples

      iex> Radixir.Key.private_key_to_secret_integer("ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17")
      {:ok, 107340927595134471984420820489673630767605194678966104711498635548873815202327}
  """
  def private_key_to_secret_integer(private_key) do
    with {:ok, keypair} <- private_key_to_keypair(private_key) do
      {:ok, :binary.decode_unsigned(keypair.privkey)}
    end
  end

  @doc """
  Signs data with provided private key.

  ## Parameters
    - `data`: Hex encoded data to be signed.
    - `private_key`: Hex encoded private key.

  ## Examples

      iex> Radixir.Key.sign_data("68656C6C6F207261646978","ed50cfe0904bfbf7668502a3f7d562c3139997255c3268c779eeff04a40f9a17")
      {:ok, "304402206f2c0f3a70c23879a44a2910f9b060e59d5b96e350605fdbee2a7a265ca503c302201043a8a957353744608c86824c286034e6166be475c7c096527a225cbdf90d0a"}
  """
  def sign_data(data, private_key) do
    with {:ok, keypair} <- private_key_to_keypair(private_key),
         {:ok, data} <- Util.decode16(data, "data") do
      {:ok, Curvy.sign(data, Curvy.Key.to_privkey(keypair), encoding: :hex, hash: :none)}
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

  defp format_keys(keypair) do
    public_key = Curvy.Key.to_pubkey(keypair)
    {mainnet_address, testnet_address} = pubkey_to_addrs(public_key)
    public_key = Util.encode16(public_key)

    private_key =
      keypair
      |> Curvy.Key.to_privkey()
      |> Util.encode16()

    %{
      mainnet_address: mainnet_address,
      testnet_address: testnet_address,
      public_key: public_key,
      private_key: private_key
    }
  end

  defp pubkey_to_addrs(public_key) do
    {Bech32.encode("rdx", <<4>> <> public_key), Bech32.encode("tdx", <<4>> <> public_key)}
  end
end
