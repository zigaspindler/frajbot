defmodule FrajBot.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :reddit_id, :string
      add :url, :string
      add :thumbnail, :string
      add :type, :string
      add :title, :string
      add :subreddit, :string

      timestamps()
    end

    create unique_index(:items, [:reddit_id])
  end
end
