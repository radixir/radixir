defmodule Radixir.Keypair do
  alias Radixir.Config

  def new() do
    Curvy.generate_key()
    |> format_keys()
  end

  def get(index) do
    {:ok, private_key} =
      Config.private_keys()
      |> String.split(",")
      |> Enum.at(index)
      |> Curvy.Util.decode(:hex)

    private_key
    |> Curvy.Key.from_privkey()
    |> format_keys()
  end

  def sign(data, private_key) do
    {:ok, private_key} = Curvy.Util.decode(private_key, :hex)
    # {:ok, data} = Curvy.Util.decode(data, :hex)
    Curvy.sign(data, private_key, encoding: :hex)
  end

  def from_private_key(private_key) do
    {:ok, private_key} = Curvy.Util.decode(private_key, :hex)

    private_key
    |> Curvy.Key.from_privkey()
    |> format_keys()
  end

  defp format_keys(keypair) do
    public_key = Curvy.Key.to_pubkey(keypair)
    radix_address = Bech32.encode(hrp(), <<4>> <> public_key)
    public_key = Curvy.Util.encode(public_key, :hex)

    private_key =
      keypair
      |> Curvy.Key.to_privkey()
      |> Curvy.Util.encode(:hex)

    %{radix_address: radix_address, public_key: public_key, private_key: private_key}
  end

  defp hrp() do
    case Config.radix_testnet() do
      "true" ->
        "tdx"

      "false" ->
        "rdx"

      _ ->
        "tdx"
    end
  end
end
