defmodule Radixir.HTTP do
  alias Radixir.Config

  @base_url Config.radix_node_url()

  def post(path, method, params, id) do
    Req.post!(
      @base_url <> path,
      {:json,
       %{
         jsonrpc: "2.0",
         method: method,
         params: params,
         id: if(id, do: id, else: UUID.uuid1())
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
    Req.get!(@base_url <> path)
    |> case do
      %{body: result, status: 200} ->
        {:ok, result}

      %{status: status} ->
        {:error, "HTTP response status code #{status}"}
    end
  end
end
