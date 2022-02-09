defmodule FrajBot.Reddit.Services.Parse do
  alias FrajBot.Repo

  alias FrajBot.Reddit.{
    Item,
    Queries,
    Services,
    Topic
  }

  def run() do
    delete_old_items()
    fetch_new_items()
  end

  defp fetch_new_items() do
    {:ok, token} = Services.Token.get_token()

    Topic
    |> Repo.all()
    |> Enum.map(fn topic ->
      topic.name
      |> Services.Api.get_posts(token)
      |> handle_response(topic.name)
    end)

    delete_old_items()
  end

  defp delete_old_items() do
    Item
    |> Queries.Item.older_than()
    |> Repo.delete_all()
  end

  defp handle_response({:ok, items}, topic) do
    items
    |> Enum.map(fn item ->
      item
      |> Map.merge(%{subreddit: topic})
      |> Item.changeset()
      |> Repo.insert()
    end)
  end

  defp handle_response(_, _),
    do: nil
end
