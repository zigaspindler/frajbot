defmodule FrajBot.Reddit do
  @moduledoc """
  The Reddit context.
  """

  import Ecto.Query, warn: false

  alias FrajBot.Repo
  alias FrajBot.Reddit.{
    Item,
    Services,
    Topic
  }

  def parse do
    Services.Parse.run()
  end

  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  def list_items do
    Repo.all(Item)
  end
end
