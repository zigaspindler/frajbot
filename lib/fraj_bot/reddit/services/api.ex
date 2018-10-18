defmodule FrajBot.Reddit.Services.Api do
  use HTTPoison.Base

  def get_posts(subreddit, token) do
    case get("/r/#{subreddit}/new", ["Authorization": "bearer #{token}"]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def process_url(url) do
    "https://oauth.reddit.com" <> url
  end

  def process_request_headers(headers) do
    headers ++ ["User-Agent": "frajbot/0.1"]
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.get("data")
    |> Map.get("children")
    |> Enum.map(&map_item/1)
    |> Enum.filter(&filter_item/1)
  end

  defp map_item(%{"data" => data}) do
    expected_fields = ~w(title url thumbnail id post_hint)

    data
    |> Map.take(expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
    |> Enum.into(%{})
    |> set_type()
  end
  defp map_item(_),
    do: nil

  defp set_type(%{url: url} = item),
    do: Map.put(item, :type, String.slice(url, -3..-1))

  defp filter_item(%{post_hint: "image", type: "jpg"}),
    do: true
  defp filter_item(%{post_hint: "image", type: "gif"}),
    do: true
  defp filter_item(_),
    do: false
end
