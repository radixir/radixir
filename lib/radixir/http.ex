defmodule Radixir.HTTP do
  def post(url, path, params) do
    Req.post!(
      url <> path,
      {:json, params},
      # TODO: remove once archive api is no longer supported
      headers: ["X-Radixdlt-Target-Gw-Api": "1.0.0"]
    )
    |> case do
      %{body: body, status: 200} ->
        {:ok, body}

      %{body: body, status: 500} ->
        {:error, body}

      %{status: status} ->
        {:error, %{"status" => status}}
    end
  end
end
