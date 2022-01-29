defmodule Radixir.Keys do
  alias Radixir.Bech32

  def new() do
    Curvy.generate_key() |> format_keys()
  end

  def from_private_key(private_key_hex) do
    with {:ok, keypair} <- private_key_to_keypair(private_key_hex) do
      {:ok, format_keys(keypair)}
    end
  end

  def address_to_public_key(address) do
    with {:ok, _hrp, <<4>> <> public_key} <- Bech32.decode(address) do
      {:ok, Curvy.Util.encode(public_key, :hex)}
    end
  end

  def private_key_to_secret(private_key_hex) do
    with {:ok, keypair} <- private_key_to_keypair(private_key_hex) do
      {:ok, :binary.decode_unsigned(keypair.privkey)}
    end
  end

  def sign_data(data, private_key_hex) do
    with {:ok, keypair} <- private_key_to_keypair(private_key_hex),
         {:ok, data} <- decode_data(data) do
      {:ok, Curvy.sign(data, Curvy.Key.to_privkey(keypair), encoding: :hex, hash: :none)}
    end
  end

  defp check_private_key_size(<<private_key::binary-size(32)>>) do
    {:ok, private_key}
  end

  defp check_private_key_size(_) do
    {:error, "invalid private key format"}
  end

  defp private_key_to_keypair(private_key_hex) do
    with {:ok, private_key} <- decode_data(private_key_hex),
         {:ok, private_key} <- check_private_key_size(private_key) do
      {:ok, Curvy.Key.from_privkey(private_key)}
    end
  end

  defp decode_data(data) do
    with {:ok, data} <- Curvy.Util.decode(data, :hex) do
      {:ok, data}
    else
      _ ->
        {:error, "invalid data format"}
    end
  end

  defp format_keys(keypair) do
    public_key = Curvy.Key.to_pubkey(keypair)
    radix_address_mainnet = Bech32.encode("rdx", <<4>> <> public_key)
    radix_address_testnet = Bech32.encode("tdx", <<4>> <> public_key)
    public_key = Curvy.Util.encode(public_key, :hex)

    private_key =
      keypair
      |> Curvy.Key.to_privkey()
      |> Curvy.Util.encode(:hex)

    %{
      radix_address: %{mainnet: radix_address_mainnet, testnet: radix_address_testnet},
      public_key: public_key,
      private_key: private_key
    }
  end
end
