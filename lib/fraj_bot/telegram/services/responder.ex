defmodule FrajBot.Telegram.Services.Responder do
  use HTTPoison.Base

  def respond(items, id, :inline) do
    data = Poison.encode!(%{
      inline_query_id: id,
      results: items,
      cache_time: 30,
      is_personal: true,
      next_offset: ""
    })
    # IO.puts data
    post("/answerInlineQuery", data)
  end
  def respond(item, id, :photo) do
    data = Poison.encode!(%{
      chat_id: id,
      photo: item.url,
      caption: "Requested by #{item.name}"
    })

    post("/sendPhoto", data)
  end
  def respond(item, id, :gif) do
    data = Poison.encode!(%{
      chat_id: id,
      animation: item.url,
      caption: "Requested by #{item.name}"
    })

    post("/sendAnimation", data)
  end

  def process_url(url) do
    "https://api.telegram.org/bot"
    |> Kernel.<>(Application.get_env(:fraj_bot, :telegram)[:bot_token])
    |> Kernel.<>(url)
  end

  def process_request_headers(headers) do
    headers ++ ["Content-Type": "application/json"]
  end
end
