defmodule Radixir.Config do
  def gateway_api_url do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:gateway_api_url)
  end

  def core_api_url do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:core_api_url)
  end

  def system_api_url do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:system_api_url)
  end

  def usernames() do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:usernames)
    |> process_usernames_passwords("no usernames")
  end

  def passwords() do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:passwords)
    |> process_usernames_passwords("no passwords")
  end

  def testnet? do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:testnet)
    |> case do
      "true" -> true
      _ -> false
    end
  end

  def auth(index) do
    with {:ok, usernames} <- usernames(),
         {:ok, passwords} <- passwords(),
         {:ok, length} <- valid_length(usernames, passwords),
         {:ok, index} <- valid_index(length, index) do
      {:ok, Enum.at(usernames, index), Enum.at(passwords, index)}
    end
  end

  def network do
    if testnet?() do
      "stokenet"
    else
      "mainnet"
    end
  end

  defp process_usernames_passwords(nil, error_message), do: {:error, error_message}

  defp process_usernames_passwords(content, error_message) do
    String.split(content, ", ")
    |> case do
      [""] -> {:error, error_message}
      items -> {:ok, items}
    end
  end

  defp valid_length(usernames, passwords) do
    usernames_length = Enum.count(usernames)
    passwords_length = Enum.count(passwords)

    if usernames_length == passwords_length do
      {:ok, passwords_length}
    else
      {:error, "usernames and passwords length mismatch"}
    end
  end

  defp valid_index(length, index) do
    if index < length && index >= 0 do
      {:ok, index}
    else
      {:error, "invalid index for accessing usernames and passwords"}
    end
  end
end
