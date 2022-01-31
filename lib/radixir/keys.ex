defmodule Radixir.Keys do
  alias Radixir.Bech32
  alias Radixir.Utils

  def new(), do: Curvy.generate_key() |> format_keys()

  def from_private_key(private_key_hex) do
    with {:ok, keypair} <- private_key_to_keypair(private_key_hex) do
      {:ok, format_keys(keypair)}
    end
  end

  def address_to_public_key(radix_address) do
    with {:ok, _hrp, <<4>> <> public_key_bytes} <- Bech32.decode(radix_address) do
      {:ok, Utils.encode16(public_key_bytes)}
    end
  end

  def private_key_to_secret(private_key_hex) do
    with {:ok, keypair} <- private_key_to_keypair(private_key_hex) do
      {:ok, :binary.decode_unsigned(keypair.privkey)}
    end
  end

  def sign_data(data, private_key_hex) do
    with {:ok, keypair} <- private_key_to_keypair(private_key_hex),
         {:ok, data} <- Utils.decode16(data, "data") do
      {:ok, Curvy.sign(data, Curvy.Key.to_privkey(keypair), encoding: :hex, hash: :none)}
    end
  end

  defp check_private_key_size(<<private_key_bytes::binary-size(32)>>),
    do: {:ok, private_key_bytes}

  defp check_private_key_size(_), do: {:error, "invalid format for private_key_hex"}

  defp private_key_to_keypair(private_key_hex) do
    with {:ok, private_key} <- Utils.decode16(private_key_hex, "private_key_hex"),
         {:ok, private_key} <- check_private_key_size(private_key) do
      {:ok, Curvy.Key.from_privkey(private_key)}
    end
  end

  defp format_keys(keypair) do
    public_key = Curvy.Key.to_pubkey(keypair)
    radix_address_mainnet = Bech32.encode("rdx", <<4>> <> public_key)
    radix_address_testnet = Bech32.encode("tdx", <<4>> <> public_key)
    public_key = Utils.encode16(public_key)

    private_key =
      keypair
      |> Curvy.Key.to_privkey()
      |> Utils.encode16()

    %{
      radix_address: %{mainnet: radix_address_mainnet, testnet: radix_address_testnet},
      public_key: public_key,
      private_key: private_key
    }
  end
end
