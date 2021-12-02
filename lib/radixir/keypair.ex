defmodule Radixir.Keypair do
  def new(options \\ []) do
    save = Keyword.get(options, :save, false)

    keypair =
      Curvy.generate_key()
      |> format_keys()

    maybe_save_keypair(save, keypair)

    keypair
  end

  def from_private_key(private_key, options \\ []) do
    save = Keyword.get(options, :save, false)
    {:ok, private_key} = Curvy.Util.decode(private_key, :hex)

    keypair =
      private_key
      |> Curvy.Key.from_privkey()
      |> format_keys()

    maybe_save_keypair(save, keypair)

    keypair
  end

  def at(index) do
    get_keypairs()
    |> Enum.at(index)
  end

  def find(value) do
    get_keypairs()
    |> do_find(value)
  end

  def sign(data, private_key) do
    {:ok, private_key} = Curvy.Util.decode(private_key, :hex)
    {:ok, data} = Curvy.Util.decode(data, :hex)
    Curvy.sign(data, private_key, encoding: :hex, hash: :none)
  end

  defp maybe_save_keypair(save, keypair) do
    exising_keypairs = get_keypairs()

    keypair_exists =
      case do_find(exising_keypairs, keypair.private_key) do
        {:ok, _} ->
          true

        _ ->
          false
      end

    if save and !keypair_exists do
      (exising_keypairs ++ [keypair])
      |> save_keypairs()
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

  defp get_keypairs() do
    with {:ok, body} <- File.read("keypairs.json"), {:ok, json} <- Jason.decode(body) do
      Enum.map(json, fn keypair ->
        %{
          radix_address: %{
            mainnet: keypair["radix_address"]["mainnet"],
            testnet: keypair["radix_address"]["testnet"]
          },
          public_key: keypair["public_key"],
          private_key: keypair["private_key"]
        }
      end)
    end
  end

  defp save_keypairs(keypairs) do
    File.write!("./keypairs.json", Jason.encode!(keypairs, pretty: true))
  end

  defp do_find(keypairs, value) do
    Enum.find(keypairs, fn k ->
      k.private_key == value ||
        k.public_key == value ||
        k.radix_address.mainnet == value ||
        k.radix_address.testnet == value
    end)
    |> case do
      nil ->
        {:error, "not found in keypairs.json"}

      keypair ->
        {:ok, keypair}
    end
  end
end
