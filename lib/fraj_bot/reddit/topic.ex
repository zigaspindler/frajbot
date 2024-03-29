defmodule FrajBot.Reddit.Topic do
  use Ecto.Schema
  import Ecto.Changeset


  schema "topics" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
