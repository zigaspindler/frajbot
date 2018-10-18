defmodule FrajBot.Reddit.Services.Parse do
  alias FrajBot.Repo
  alias FrajBot.Reddit.{
    Item,
    Services,
    Topic
  }

  def run() do
    {:ok, token} = Services.Token.get_token()
    Topic
    |> Repo.all
    |> Enum.map(fn topic ->
      topic.name
      |> Services.Api.get_posts(token)
      |> handle_response(topic.name)
    end)
  end

  defp handle_response({:ok, items}, topic) do
    items
    |> Enum.map(fn item ->
      item
      |> Map.merge(%{subreddit: topic})
      |> Item.changeset
      |> Repo.insert
    end)
  end
  defp handle_response(_, _),
    do: nil
end
