defmodule FrajBot.Telegram do
  alias FrajBot.Repo
  alias FrajBot.Reddit.{
    Item,
    Queries
  }
  alias FrajBot.Telegram.Services.Responder

  def respond_to_inline_query(%{"inline_query" => %{"query" => query, "id" => id}}) do
    query
    |> String.downcase
    |> Queries.Item.find
    |> Repo.all
    |> Enum.map(&format_item/1)
    |> Responder.respond(id, :inline)
  end
  def respond_to_inline_query(%{"message" => %{"chat" => %{"id" => id}, "from" => %{"first_name" => name}, "text" => "/photo"}}) do
    Queries.Item.random_photo()
    |> Repo.one
    |> Map.put(:name, name)
    |> Responder.respond(id, :photo)
  end
  def respond_to_inline_query(%{"message" => %{"chat" => %{"id" => id}, "from" => %{"first_name" => name}, "text" => "/gif"}}) do
    Queries.Item.random_gif()
    |> Repo.one
    |> Map.put(:name, name)
    |> Responder.respond(id, :gif)
  end
  def respond_to_inline_query(_),
    do: nil

  defp format_item(%Item{type: "gif"} = item) do
    %{
      type: "gif",
      gif_url: item.url,
      thumb_url: item.thumbnail,
      id: item.id
    }
  end
  defp format_item(%Item{} = item) do
    %{
      type: "photo",
      photo_url: item.url,
      thumb_url: item.thumbnail,
      id: item.id
    }
  end
end
