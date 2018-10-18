defmodule FrajBot.Reddit.Queries.Item do
  import Ecto.Query

  alias FrajBot.Reddit.Item

  def find(query) do
    Item
    |> find(query)
    |> random_sort
    |> limit_results
  end

  def random_photo() do
    Item
    |> photo
    |> random_sort
    |> limit_results(1)
  end

  def random_gif() do
    Item
    |> gif
    |> random_sort
    |> limit_results(1)
  end

  def find(query, term) do
    from i in query,
    where: like(fragment("lower(?)", i.title), ^("%#{term}%")) or like(fragment("lower(?)", i.subreddit), ^("%#{term}%"))
  end

  def random_sort(query) do
    from i in query,
    order_by: fragment("RANDOM()")
  end

  def limit_results(query, limit \\ 15) do
    from i in query,
    limit: ^limit
  end

  def photo(query) do
    from i in query,
    where: i.type == ^"jpg"
  end

  def gif(query) do
    from i in query,
    where: i.type == ^"gif"
  end
end
