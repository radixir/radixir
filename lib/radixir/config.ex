defmodule Radixir.Config do
  def radix_gateway_api_url do
    :radixir
    |> Application.get_env(__MODULE__, [])
    |> Keyword.get(:radix_gateway_api_url)
  end

  def radix_core_api_url do
    :radixir
    |> Application.get_env(__MODULE__, [])
    |> Keyword.get(:radix_core_api_url)
  end

  def radix_system_api_url do
    :radixir
    |> Application.get_env(__MODULE__, [])
    |> Keyword.get(:radix_system_api_url)
  end

  def radix_usernames() do
    :radixir
    |> Application.get_env(__MODULE__, [])
    |> Keyword.get(:radix_usernames, "")
    |> String.split(", ")
  end

  def radix_passwords() do
    :radixir
    |> Application.get_env(__MODULE__, [])
    |> Keyword.get(:radix_passwords, "")
    |> String.split(", ")
  end

  def radix_testnet? do
    :radixir
    |> Application.get_env(__MODULE__, [])
    |> Keyword.get(:radix_testnet)
    |> case do
      "true" -> true
      _ -> false
    end
  end

  @spec radix_auth(integer) :: [{:password, any} | {:username, any}, ...]
  def radix_auth(index) do
    usernames = radix_usernames()
    passwords = radix_passwords()
    [username: Enum.at(usernames, index), password: Enum.at(passwords, index)]
  end

  def network do
    if radix_testnet?() do
      "stokenet"
    else
      "mainnet"
    end
  end
end
