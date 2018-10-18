defmodule FrajBot.Reddit.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias FrajBot.Reddit.Item

  schema "items" do
    field :reddit_id, :string
    field :subreddit, :string
    field :thumbnail, :string
    field :title, :string
    field :type, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:reddit_id, :url, :thumbnail, :type, :title, :subreddit])
    |> validate_required([:reddit_id, :url, :thumbnail, :type, :title, :subreddit])
    |> unique_constraint(:reddit_id)
  end

  def changeset(%{id: id} = attrs) do
    %Item{} |> changeset(Map.merge(attrs, %{reddit_id: id}))
  end
end
