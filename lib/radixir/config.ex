defmodule Radixir.Config do
  def radix_gateway_api_url do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:radix_gateway_api_url)
  end

  def radix_core_api_url do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:radix_core_api_url)
  end

  def radix_system_api_url do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:radix_system_api_url)
  end

  def radix_usernames() do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:radix_usernames)
    |> process_usernames_passwords("no usernames")
  end

  def radix_passwords() do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:radix_passwords)
    |> process_usernames_passwords("no passwords")
  end

  def radix_testnet? do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:radix_testnet)
    |> case do
      "true" -> true
      _ -> false
    end
  end

  def radix_auth(index) do
    with {:ok, usernames} <- radix_usernames(),
         {:ok, passwords} <- radix_passwords(),
         {:ok, length} <- valid_length(usernames, passwords),
         {:ok, index} <- valid_index(length, index) do
      {:ok, Enum.at(usernames, index), Enum.at(passwords, index)}
    end
  end

  def network do
    if radix_testnet?() do
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
