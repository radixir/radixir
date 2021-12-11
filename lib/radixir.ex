defmodule Radixir do
  alias Radixir.Bech32
  alias Radixir.Config
  alias Radixir.HTTP

  def new_keypair(options \\ []) do
    save = Keyword.get(options, :save, false)

    keypair =
      Curvy.generate_key()
      |> format_keys()

    maybe_save_keypair(keypair, save)

    keypair
  end

  def keypair_from_private_key(private_key, options \\ []) when is_binary(private_key) do
    save = Keyword.get(options, :save, false)

    with {:ok, keypair} <- private_key_to_keypair(private_key) do
      formatted_keys = format_keys(keypair)
      maybe_save_keypair(formatted_keys, save)
      {:ok, formatted_keys}
    end
  end

  def keypair_at_index(index) when is_integer(index) do
    with {:ok, keypairs} <- get_keypairs(),
         keypair when is_map(keypair) <- Enum.at(keypairs, index) do
      {:ok, keypair}
    else
      _ ->
        {:error, "invalid index"}
    end
  end

  def find_keypair(value) when is_binary(value) do
    with {:ok, keypairs} <- get_keypairs() do
      do_find(keypairs, value)
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

  defp maybe_save_keypair(keypair, save) do
    {keypair_exists, existing_keypairs} =
      with {:ok, existing_keypairs} <- get_keypairs() do
        keypair_exists =
          case do_find(existing_keypairs, keypair.private_key) do
            {:ok, _} ->
              true

            _ ->
              false
          end

        {keypair_exists, existing_keypairs}
      else
        _ ->
          {false, []}
      end

    if save and !keypair_exists do
      (existing_keypairs ++ [keypair])
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
    keypairs_file_name = Config.keypairs_file_name()

    with {:ok, body} <- File.read(keypairs_file_name), {:ok, json} <- Jason.decode(body) do
      keypairs =
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

      {:ok, keypairs}
    else
      {:error, :enoent} ->
        {:error, "could not find #{keypairs_file_name}"}

      {:error, %Jason.DecodeError{}} ->
        {:error, "could not parse #{keypairs_file_name}"}
    end
  end

  defp save_keypairs(keypairs) do
    File.write!("#{Config.keypairs_file_name()}", Jason.encode!(keypairs, pretty: true))
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
        {:error, "not found in #{Config.keypairs_file_name()}"}

      keypair ->
        {:ok, keypair}
    end
  end

  defp double_hash(data) do
    result = :crypto.hash(:sha256, data)
    :crypto.hash(:sha256, result)
  end

  defp verify_blob_hash(blob, hash_of_blob_to_sign) do
    {:ok, binary_blob} = Curvy.Util.decode(blob, :hex)

    double_hash_hex =
      binary_blob
      |> double_hash()
      |> Curvy.Util.encode(:hex)

    if double_hash_hex == hash_of_blob_to_sign do
      :ok
    else
      {:error, "double hash of blob does not match hashOfBlobToSign"}
    end
  end

  def send_xrd(from, to, amount) do
    with {:ok, %{private_key: private_key, public_key: public_key_of_signer}} <-
           find_keypair(from),
         {:ok, _, %{"rri" => rri}} <- get_native_token(),
         actions <- [
           %{
             amount: amount,
             from: from,
             rri: rri,
             to: to,
             type: "TokenTransfer"
           }
         ],
         {:ok, _,
          %{"transaction" => %{"blob" => blob, "hashOfBlobToSign" => hash_of_blob_to_sign}}} <-
           build_transaction(actions, from),
         :ok <- verify_blob_hash(blob, hash_of_blob_to_sign) do
      signature_der = sign_data(hash_of_blob_to_sign, private_key)
      finalize_transaction(blob, signature_der, public_key_of_signer, true)
    end
  end

  def get_network_id(id \\ nil) do
    HTTP.post("/archive", "network.get_id", %{}, id)
  end

  def get_native_token(id \\ nil) do
    HTTP.post("/archive", "tokens.get_native_token", %{}, id)
  end

  def get_token_info(rri, id \\ nil) do
    HTTP.post("/archive", "tokens.get_info", %{rri: rri}, id)
  end

  def get_next_epoch_validator_set(size, cursor, id \\ nil) do
    HTTP.post("/archive", "validators.get_next_epoch_set", %{size: size, cursor: cursor}, id)
  end

  def lookup_validator(address, id \\ nil) do
    HTTP.post("/archive", "validators.lookup_validator", %{validatorAddress: address}, id)
  end

  def lookup_transaction(transaction_id, id \\ nil) do
    HTTP.post("/archive", "transactions.lookup_transaction", %{txID: transaction_id}, id)
  end

  def get_transaction_status(transaction_id, id \\ nil) do
    HTTP.post("/archive", "transactions.get_transaction_status", %{txID: transaction_id}, id)
  end

  def get_token_balances(address, id \\ nil) do
    HTTP.post("/archive", "account.get_balances", %{address: address}, id)
  end

  def get_transaction_history(address, size, cursor, id \\ nil) do
    HTTP.post(
      "/archive",
      "account.get_transaction_history",
      %{address: address, size: size, cursor: cursor},
      id
    )
  end

  def get_stake_positions(address, id \\ nil) do
    HTTP.post("/archive", "account.get_stake_positions", %{address: address}, id)
  end

  def get_unstake_positions(address, id \\ nil) do
    HTTP.post("/archive", "account.get_unstake_positions", %{address: address}, id)
  end

  def get_transaction_demand(id \\ nil) do
    HTTP.post("/archive", "network.get_demand", %{}, id)
  end

  def get_network_throughput(id \\ nil) do
    HTTP.post("/archive", "network.get_throughput", %{}, id)
  end

  def build_transaction(actions, fee_payer, id \\ nil) do
    HTTP.post(
      "/construction",
      "construction.build_transaction",
      %{actions: actions, feePayer: fee_payer},
      id
    )
  end

  def finalize_transaction(blob, signature_der, public_key_of_signer, immediate_submit, id \\ nil) do
    HTTP.post(
      "/construction",
      "construction.finalize_transaction",
      %{
        blob: blob,
        signatureDER: signature_der,
        publicKeyOfSigner: public_key_of_signer,
        immediateSubmit: immediate_submit
      },
      id
    )
  end

  def submit_transaction(blob, transaction_id, id \\ nil) do
    HTTP.post(
      "/construction",
      "construction.submit_transaction",
      %{
        blob: blob,
        txID: transaction_id
      },
      id
    )
  end
end
