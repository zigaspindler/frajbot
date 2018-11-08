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
  def respond_to_inline_query(%{"message" => %{"text" => "/photo"}} = data),
    do: respond_with_jpg(data)
  def respond_to_inline_query(%{"message" => %{"text" => "/photo@frajbot"}} = data),
    do: respond_with_jpg(data)
  def respond_to_inline_query(%{"message" => %{"text" => "/gif"}} = data),
    do: respond_with_gif(data)
  def respond_to_inline_query(%{"message" => %{"text" => "/gif@frajbot"}} = data),
    do: respond_with_gif(data)
  def respond_to_inline_query(_),
    do: nil

  defp respond_with_jpg(%{"message" => %{"chat" => %{"id" => id}, "from" => %{"first_name" => name}}}) do
    Queries.Item.random_photo()
    |> Repo.one
    |> Map.put(:name, name)
    |> Responder.respond(id, :photo)
  end

  defp respond_with_gif(%{"message" => %{"chat" => %{"id" => id}, "from" => %{"first_name" => name}}}) do
    Queries.Item.random_gif()
    |> Repo.one
    |> Map.put(:name, name)
    |> Responder.respond(id, :gif)
  end

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
