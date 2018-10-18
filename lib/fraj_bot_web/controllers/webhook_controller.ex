defmodule FrajBotWeb.WebhookController do
  use FrajBotWeb, :controller

  alias FrajBot.Telegram

  def index(conn, params) do
    Task.start(fn ->
      Telegram.respond_to_inline_query(params)
    end)
    
    render(conn, "index.json", %{})
  end
end
