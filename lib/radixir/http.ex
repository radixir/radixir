defmodule Radixir.HTTP do
  @moduledoc false
  def post(url, path, body, options \\ []) do
    Req.post!(
      url <> path,
      {:json, body},
      options
    )
    |> handle_response()
  end

  def get(url, path, options \\ []) do
    Req.get!(url <> path, options)
    |> handle_response()
  end

  defp handle_response(response) do
    case response do
      %{body: body, status: 200} ->
        {:ok, body}

      %{body: body, status: 500} ->
        {:error, body}

      %{status: status} ->
        {:error, %{"status" => status}}
    end
  end
end
