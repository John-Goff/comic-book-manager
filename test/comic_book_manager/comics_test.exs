defmodule ComicBookManager.ComicsTest do
  use ComicBookManager.DataCase

  alias ComicBookManager.Comics

  describe "comics" do
    alias ComicBookManager.Comics.Comic

    import ComicBookManager.ComicsFixtures

    @invalid_attrs %{issue_number: nil, published_at: nil, read_percentage: nil}

    test "list_comics/0 returns all comics" do
      comic = comic_fixture()
      assert Comics.list_comics() == [comic]
    end

    test "get_comic!/1 returns the comic with given id" do
      comic = comic_fixture()
      assert Comics.get_comic!(comic.id) == comic
    end

    test "create_comic/1 with valid data creates a comic" do
      valid_attrs = %{issue_number: 42, published_at: ~D[2022-08-17], read_percentage: 42}

      assert {:ok, %Comic{} = comic} = Comics.create_comic(valid_attrs)
      assert comic.issue_number == 42
      assert comic.published_at == ~D[2022-08-17]
      assert comic.read_percentage == 42
    end

    test "create_comic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comics.create_comic(@invalid_attrs)
    end

    test "update_comic/2 with valid data updates the comic" do
      comic = comic_fixture()
      update_attrs = %{issue_number: 43, published_at: ~D[2022-08-18], read_percentage: 43}

      assert {:ok, %Comic{} = comic} = Comics.update_comic(comic, update_attrs)
      assert comic.issue_number == 43
      assert comic.published_at == ~D[2022-08-18]
      assert comic.read_percentage == 43
    end

    test "update_comic/2 with invalid data returns error changeset" do
      comic = comic_fixture()
      assert {:error, %Ecto.Changeset{}} = Comics.update_comic(comic, @invalid_attrs)
      assert comic == Comics.get_comic!(comic.id)
    end

    test "delete_comic/1 deletes the comic" do
      comic = comic_fixture()
      assert {:ok, %Comic{}} = Comics.delete_comic(comic)
      assert_raise Ecto.NoResultsError, fn -> Comics.get_comic!(comic.id) end
    end

    test "change_comic/1 returns a comic changeset" do
      comic = comic_fixture()
      assert %Ecto.Changeset{} = Comics.change_comic(comic)
    end
  end

  describe "publishers" do
    alias ComicBookManager.Comics.Publisher

    import ComicBookManager.ComicsFixtures

    @invalid_attrs %{created_at: nil, name: nil}

    test "list_publishers/0 returns all publishers" do
      publisher = publisher_fixture()
      assert Comics.list_publishers() == [publisher]
    end

    test "get_publisher!/1 returns the publisher with given id" do
      publisher = publisher_fixture()
      assert Comics.get_publisher!(publisher.id) == publisher
    end

    test "create_publisher/1 with valid data creates a publisher" do
      valid_attrs = %{created_at: ~D[2022-08-17], name: "some name"}

      assert {:ok, %Publisher{} = publisher} = Comics.create_publisher(valid_attrs)
      assert publisher.created_at == ~D[2022-08-17]
      assert publisher.name == "some name"
    end

    test "create_publisher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comics.create_publisher(@invalid_attrs)
    end

    test "update_publisher/2 with valid data updates the publisher" do
      publisher = publisher_fixture()
      update_attrs = %{created_at: ~D[2022-08-18], name: "some updated name"}

      assert {:ok, %Publisher{} = publisher} = Comics.update_publisher(publisher, update_attrs)
      assert publisher.created_at == ~D[2022-08-18]
      assert publisher.name == "some updated name"
    end

    test "update_publisher/2 with invalid data returns error changeset" do
      publisher = publisher_fixture()
      assert {:error, %Ecto.Changeset{}} = Comics.update_publisher(publisher, @invalid_attrs)
      assert publisher == Comics.get_publisher!(publisher.id)
    end

    test "delete_publisher/1 deletes the publisher" do
      publisher = publisher_fixture()
      assert {:ok, %Publisher{}} = Comics.delete_publisher(publisher)
      assert_raise Ecto.NoResultsError, fn -> Comics.get_publisher!(publisher.id) end
    end

    test "change_publisher/1 returns a publisher changeset" do
      publisher = publisher_fixture()
      assert %Ecto.Changeset{} = Comics.change_publisher(publisher)
    end
  end

  describe "series" do
    alias ComicBookManager.Comics.Series

    import ComicBookManager.ComicsFixtures

    @invalid_attrs %{name: nil, published_at: nil}

    test "list_series/0 returns all series" do
      series = series_fixture()
      assert Comics.list_series() == [series]
    end

    test "get_series!/1 returns the series with given id" do
      series = series_fixture()
      assert Comics.get_series!(series.id) == series
    end

    test "create_series/1 with valid data creates a series" do
      valid_attrs = %{name: "some name", published_at: ~D[2022-08-17]}

      assert {:ok, %Series{} = series} = Comics.create_series(valid_attrs)
      assert series.name == "some name"
      assert series.published_at == ~D[2022-08-17]
    end

    test "create_series/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comics.create_series(@invalid_attrs)
    end

    test "update_series/2 with valid data updates the series" do
      series = series_fixture()
      update_attrs = %{name: "some updated name", published_at: ~D[2022-08-18]}

      assert {:ok, %Series{} = series} = Comics.update_series(series, update_attrs)
      assert series.name == "some updated name"
      assert series.published_at == ~D[2022-08-18]
    end

    test "update_series/2 with invalid data returns error changeset" do
      series = series_fixture()
      assert {:error, %Ecto.Changeset{}} = Comics.update_series(series, @invalid_attrs)
      assert series == Comics.get_series!(series.id)
    end

    test "delete_series/1 deletes the series" do
      series = series_fixture()
      assert {:ok, %Series{}} = Comics.delete_series(series)
      assert_raise Ecto.NoResultsError, fn -> Comics.get_series!(series.id) end
    end

    test "change_series/1 returns a series changeset" do
      series = series_fixture()
      assert %Ecto.Changeset{} = Comics.change_series(series)
    end
  end

  describe "universes" do
    alias ComicBookManager.Comics.Universe

    import ComicBookManager.ComicsFixtures

    @invalid_attrs %{first_published_at: nil, name: nil}

    test "list_universes/0 returns all universes" do
      universe = universe_fixture()
      assert Comics.list_universes() == [universe]
    end

    test "get_universe!/1 returns the universe with given id" do
      universe = universe_fixture()
      assert Comics.get_universe!(universe.id) == universe
    end

    test "create_universe/1 with valid data creates a universe" do
      valid_attrs = %{first_published_at: ~D[2022-08-17], name: "some name"}

      assert {:ok, %Universe{} = universe} = Comics.create_universe(valid_attrs)
      assert universe.first_published_at == ~D[2022-08-17]
      assert universe.name == "some name"
    end

    test "create_universe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comics.create_universe(@invalid_attrs)
    end

    test "update_universe/2 with valid data updates the universe" do
      universe = universe_fixture()
      update_attrs = %{first_published_at: ~D[2022-08-18], name: "some updated name"}

      assert {:ok, %Universe{} = universe} = Comics.update_universe(universe, update_attrs)
      assert universe.first_published_at == ~D[2022-08-18]
      assert universe.name == "some updated name"
    end

    test "update_universe/2 with invalid data returns error changeset" do
      universe = universe_fixture()
      assert {:error, %Ecto.Changeset{}} = Comics.update_universe(universe, @invalid_attrs)
      assert universe == Comics.get_universe!(universe.id)
    end

    test "delete_universe/1 deletes the universe" do
      universe = universe_fixture()
      assert {:ok, %Universe{}} = Comics.delete_universe(universe)
      assert_raise Ecto.NoResultsError, fn -> Comics.get_universe!(universe.id) end
    end

    test "change_universe/1 returns a universe changeset" do
      universe = universe_fixture()
      assert %Ecto.Changeset{} = Comics.change_universe(universe)
    end
  end
end
