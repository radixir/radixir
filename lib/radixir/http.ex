defmodule Radixir.HTTP do
  def post(url, path, method, params, id) do
    Req.post!(
      url <> path,
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
        {:error, %{"status" => status}}
    end
  end

  def get(url, path) do
    Req.get!(url <> path)
    |> case do
      %{body: result, status: 200} ->
        {:ok, result}

      %{status: status} ->
        {:error, "HTTP response status code #{status}"}
    end
  end
end
