defmodule Radixir.Keypairs do
  alias Radixir.Config

  def new() do
    keypair = Curvy.generate_key()
    radix_address = keypair_to_radix_address(keypair)
    private_key = keypair |> Curvy.Key.to_privkey() |> Curvy.Util.encode(:hex)
    {radix_address, private_key}
  end

  def get(index) do
    {:ok, private_key} =
      Config.private_keys() |> String.split(",") |> Enum.at(index) |> Curvy.Util.decode(:hex)

    keypair = Curvy.Key.from_privkey(private_key)
    radix_address = keypair_to_radix_address(keypair)
    {radix_address, private_key}
  end

  defp keypair_to_radix_address(keypair) do
    public = Curvy.Key.to_pubkey(keypair)
    Bech32.encode("rdx", <<4>> <> public)
  end
end
