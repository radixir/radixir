defmodule Radixir.HTTP do
  def post(url, path, params, options \\ []) do
    Req.post!(
      url <> path,
      {:json, params},
      options
    )
    |> handle_response()
  end

  def get(url, path, options \\ []) do
    options =
      [headers: ["content-ype": "application/json"]]
      |> Keyword.merge(options)

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
