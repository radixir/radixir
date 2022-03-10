defmodule Radixir.Config do
  @moduledoc false
  # @moduledoc """
  # Configuration helpers.
  # """

  @type url :: String.t()
  @type username :: String.t()
  @type password :: String.t()
  @type error_message :: String.t()
  @type mnemonic :: String.t()

  @doc """
  Fetches gateway api url.
  """
  @spec gateway_api_url() :: {:ok, url} | {:error, error_message}
  def gateway_api_url, do: get_env(:gateway_api_url)

  @doc """
  Fetches core api url.
  """
  @spec core_api_url() :: {:ok, url} | {:error, error_message}
  def core_api_url, do: get_env(:core_api_url)

  @doc """
  Fetches system api url.
  """
  @spec system_api_url() :: {:ok, url} | {:error, error_message}
  def system_api_url, do: get_env(:system_api_url)

  @doc """
  Fetches mnemonic.
  """
  @spec mnemonic() :: {:ok, mnemonic} | {:error, error_message}
  def mnemonic, do: get_env(:mnemonic)

  @doc """
  Fetches usernames.

  ## Note
  See `.envrc.example` for required format of usernames string.
  """
  @spec usernames() :: {:ok, list(username)} | {:error, error_message}
  def usernames() do
    with {:ok, usernames} <- get_env(:usernames) do
      process_usernames_passwords(usernames, "no usernames")
    end
  end

  @doc """
  Fetches passwords.

  ## Note
  See `.envrc.example` for required format of passwords string.
  """
  @spec passwords() :: {:ok, list(password)} | {:error, error_message}
  def passwords() do
    with {:ok, passwords} <- get_env(:passwords) do
      process_usernames_passwords(passwords, "no passwords")
    end
  end

  @doc """
  Specifies whether or not the testnet is being used.
  """
  @spec testnet?() :: boolean()
  def testnet? do
    with {:ok, testnet} <- get_env(:testnet) do
      if testnet == "true" do
        true
      else
        false
      end
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

  defp get_app_env() do
    :radixir
    |> Application.get_env(__MODULE__)
    |> handle_app_env()
  end

  defp handle_app_env(nil), do: {:error, "no configuration parameters found"}

  defp handle_app_env(value), do: {:ok, value}

  defp get_env_value(envs, key) do
    case Keyword.get(envs, key) do
      nil -> {:error, "#{key} not found in configuration"}
      result -> {:ok, result}
    end
  end

  defp get_env(key) do
    with {:ok, envs} <- get_app_env() do
      get_env_value(envs, key)
    end
  end
end
