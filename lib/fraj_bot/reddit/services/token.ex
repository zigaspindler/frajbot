defmodule FrajBot.Reddit.Services.Token do
  use HTTPoison.Base

  def get_token do
    case post("/access_token", "grant_type=client_credentials") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def process_url(url) do
    "https://www.reddit.com/api/v1" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.get("access_token")
  end

  def process_request_options(options) do
    client_id = Application.get_env(:fraj_bot, :reddit)[:client_id]
    secret = Application.get_env(:fraj_bot, :reddit)[:secret]
    hackney = [basic_auth: {client_id, secret}]
    options ++ [hackney: hackney]
  end

  def process_request_headers(headers) do
    headers ++ ["Content-Type": "application/x-www-form-urlencoded"]
  end
end
