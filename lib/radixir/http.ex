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
      %{body: %{"result" => _result, "id" => _id} = body} ->
        {:ok, Map.delete(body, "jsonrpc")}

      %{body: %{"error" => _error, "id" => _id} = body} ->
        {:error, Map.delete(body, "jsonrpc")}

      %{status: status} ->
        {:error, %{"status" => status}}
    end
  end
end
