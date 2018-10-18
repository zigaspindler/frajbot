defmodule FrajBotWeb.WebhookView do
  use FrajBotWeb, :view

  def render("index.json", _),
    do: %{status: :ok}
end
