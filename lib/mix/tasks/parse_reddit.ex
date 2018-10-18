defmodule Mix.Tasks.FrajBot.ParseReddit do
  use Mix.Task

  import Mix.Ecto

  @shortdoc "Parses Topics on Reddit"

  def run(_args) do
    HTTPoison.start()
    ensure_started(FrajBot.Repo, [])

    FrajBot.Reddit.parse()
    
    Mix.shell.info "Done!"
  end
end
