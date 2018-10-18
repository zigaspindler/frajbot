defmodule FrajBotWeb.Router do
  use FrajBotWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FrajBotWeb do
    pipe_through :api

    post "/webhook", WebhookController, :index
  end
end
