defmodule Radixir.HTTP do
  def post(url, path, params) do
    Req.post!(
      url <> path,
      {:json, params},
      # TODO: remove once archive api is no longer supported
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
    |> handle_response()
  end

  def get(url, path) do
    Req.get!(url <> path)
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
