use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fraj_bot, FrajBotWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :fraj_bot, FrajBot.Repo,
  username: "postgres",
  password: "postgres",
  database: "fraj_bot_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
