defmodule Radixir.Config do
  @moduledoc """
  Configuration helpers.
  """

  @type url :: String.t()
  @type username :: String.t()
  @type password :: String.t()
  @type error_message :: String.t()
  @type mnemonic :: String.t()

  @doc """
  Fetches gateway api url.
  """
  @spec gateway_api_url() :: url | nil
  def gateway_api_url do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:gateway_api_url)
  end

  @doc """
  Fetches core api url.
  """
  @spec core_api_url() :: url | nil
  def core_api_url do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:core_api_url)
  end

  @doc """
  Fetches system api url.
  """
  @spec system_api_url() :: url | nil
  def system_api_url do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:system_api_url)
  end

  @doc """
  Fetches mnemonic.
  """
  @spec mnemonic() :: url | nil
  def mnemonic do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:mnemonic)
  end

  @doc """
  Fetches usernames.

  ## Note
  See `.envrc.example` for required format of usernames string.
  """
  @spec usernames() :: {:ok, list(username)} | {:error, error_message}
  def usernames() do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:usernames)
    |> process_usernames_passwords("no usernames")
  end

  @doc """
  Fetches passwords.

  ## Note
  See `.envrc.example` for required format of passwords string.
  """
  @spec passwords() :: {:ok, list(password)} | {:error, error_message}
  def passwords() do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:passwords)
    |> process_usernames_passwords("no passwords")
  end

  @doc """
  Specifies whether or not the testnet is being used.
  """
  @spec testnet?() :: boolean()
  def testnet? do
    :radixir
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:testnet)
    |> case do
      "true" -> true
      _ -> false
    end
  end

  @doc """
  Fetches the username / password at specified index.

  ## Example

  If the following usernames and passwords are exported as follows:
  ```
  export USERNAMES='admin, superadmin, metrics'
  export PASSWORDS='funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!'
  ```
  then `auth(0)` would return `{:ok, "admin", "funny cats very Jack 21!"}`
  """
  @spec auth(non_neg_integer()) :: {:ok, username, password} | {:error, error_message}
  def auth(index) do
    with {:ok, usernames} <- usernames(),
         {:ok, passwords} <- passwords(),
         {:ok, length} <- valid_length(usernames, passwords),
         {:ok, index} <- valid_index(length, index) do
      {:ok, Enum.at(usernames, index), Enum.at(passwords, index)}
    end
  end

  @doc """
  Fetches the network being used.

  ## Note
  The two possibilities are `stokenet` or `mainnet`.
  """
  @spec network() :: String.t()
  def network do
    if testnet?() do
      "stokenet"
    else
      "mainnet"
    end
  end

  @doc """
  Fetches the network's native token rri.

  ## Note
  The two possibilities are `xrd_rr1qy5wfsfh` for mainnet or `xrd_tr1qyf0x76s` for stokenet.
  """
  @spec network_native_token_rri() :: String.t()
  def network_native_token_rri do
    case network() do
      "mainnet" ->
        "xrd_rr1qy5wfsfh"

      "stokenet" ->
        "xrd_tr1qyf0x76s"
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
