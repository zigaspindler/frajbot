defmodule FrajBot.RedditTest do
  use FrajBot.DataCase

  alias FrajBot.Reddit

  describe "topics" do
    alias FrajBot.Reddit.Topic

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reddit.create_topic()

      topic
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Reddit.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Reddit.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Reddit.create_topic(@valid_attrs)
      assert topic.name == "some name"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reddit.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{} = topic} = Reddit.update_topic(topic, @update_attrs)

      
      assert topic.name == "some updated name"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Reddit.update_topic(topic, @invalid_attrs)
      assert topic == Reddit.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Reddit.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Reddit.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Reddit.change_topic(topic)
    end
  end

  describe "items" do
    alias FrajBot.Reddit.Item

    @valid_attrs %{reddit_id: "some reddit_id", subreddit: "some subreddit", thumbnail: "some thumbnail", title: "some title", type: "some type", url: "some url"}
    @update_attrs %{reddit_id: "some updated reddit_id", subreddit: "some updated subreddit", thumbnail: "some updated thumbnail", title: "some updated title", type: "some updated type", url: "some updated url"}
    @invalid_attrs %{reddit_id: nil, subreddit: nil, thumbnail: nil, title: nil, type: nil, url: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reddit.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Reddit.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Reddit.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Reddit.create_item(@valid_attrs)
      assert item.reddit_id == "some reddit_id"
      assert item.subreddit == "some subreddit"
      assert item.thumbnail == "some thumbnail"
      assert item.title == "some title"
      assert item.type == "some type"
      assert item.url == "some url"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reddit.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Reddit.update_item(item, @update_attrs)

      
      assert item.reddit_id == "some updated reddit_id"
      assert item.subreddit == "some updated subreddit"
      assert item.thumbnail == "some updated thumbnail"
      assert item.title == "some updated title"
      assert item.type == "some updated type"
      assert item.url == "some updated url"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Reddit.update_item(item, @invalid_attrs)
      assert item == Reddit.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Reddit.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Reddit.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Reddit.change_item(item)
    end
  end
end
