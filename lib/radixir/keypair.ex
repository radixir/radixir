defmodule Radixir.Keypair do
  alias Radixir.Bech32

  def new() do
    Curvy.generate_key() |> format_keys()
  end

  def from_private_key(private_key) when is_binary(private_key) do
    with {:ok, keypair} <- private_key_to_keypair(private_key) do
      {:ok, format_keys(keypair)}
    end
  end

  def sign_data(data, private_key)
      when is_binary(data)
      when is_binary(private_key) do
    with {:ok, keypair} <- private_key_to_keypair(private_key),
         {:ok, data} <- validate_data(data) do
      Curvy.sign(data, Curvy.Key.to_privkey(keypair), encoding: :hex, hash: :none)
    end
  end

  defp private_key_to_keypair(private_key) do
    with {:ok, private_key} <- Curvy.Util.decode(private_key, :hex),
         <<private_key::binary-size(32)>> <- private_key do
      {:ok, Curvy.Key.from_privkey(private_key)}
    else
      _ ->
        {:error, "invalid private key format"}
    end
  end

  defp validate_data(data) do
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
