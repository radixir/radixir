defmodule Radixir.HTTP do
  alias Radixir.Config

  def post(path, method, params, id) do
    Req.post!(
      Config.radix_node_url() <> path,
      {:json,
       %{
         jsonrpc: "2.0",
         method: method,
         params: params,
         id: if(id, do: id, else: :crypto.strong_rand_bytes(7) |> Base.encode16(case: :lower))
       }}
    )
    |> case do
      %{body: %{"result" => result, "id" => id}} ->
        {:ok, id, result}

      %{body: %{"error" => error, "id" => id}} ->
        {:error, id, error}

      %{status: status} ->
        {:error, "HTTP response status code #{status}"}
    end
  end

  def get(path) do
    Req.get!(Config.radix_node_url() <> path)
    |> case do
      %{body: result, status: 200} ->
        {:ok, result}

      %{status: status} ->
        {:error, "HTTP response status code #{status}"}
    end
  end
end
