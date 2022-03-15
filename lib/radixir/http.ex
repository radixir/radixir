defmodule Radixir.HTTP do
  @moduledoc false

  @type url :: String.t()
  @type path :: String.t()
  @type body :: map
  @type options :: keyword

  @callback post(url, path, body, options) :: {:ok, map} | {:error, map}
  def post(url, path, body, options \\ []) do
    try do
      Req.post!(
        url <> path,
        {:json, body},
        options
      )
      |> handle_response()
    rescue
      e in Mint.TransportError ->
        {:error, "transport error: #{e.reason}"}
    end
  end

  @callback get(url, path, options) :: {:ok, map} | {:error, map}
  def get(url, path, options \\ []) do
    try do
      Req.get!(url <> path, options)
      |> handle_response()
    rescue
      e in Mint.TransportError ->
        {:error, "transport error: #{e.reason}"}
    end
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
