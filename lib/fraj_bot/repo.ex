defmodule FrajBot.Repo do
  use Ecto.Repo,
    otp_app: :fraj_bot,
    adapter: Ecto.Adapters.Postgres
end
