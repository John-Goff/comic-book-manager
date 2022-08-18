defmodule ComicBookManager.ComicsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ComicBookManager.Comics` context.
  """

  @doc """
  Generate a comic.
  """
  def comic_fixture(attrs \\ %{}) do
    {:ok, comic} =
      attrs
      |> Enum.into(%{
        issue_number: 42,
        published_at: ~D[2022-08-17],
        read_percentage: 42
      })
      |> ComicBookManager.Comics.create_comic()

    comic
  end

  @doc """
  Generate a publisher.
  """
  def publisher_fixture(attrs \\ %{}) do
    {:ok, publisher} =
      attrs
      |> Enum.into(%{
        created_at: ~D[2022-08-17],
        name: "some name"
      })
      |> ComicBookManager.Comics.create_publisher()

    publisher
  end

  @doc """
  Generate a series.
  """
  def series_fixture(attrs \\ %{}) do
    {:ok, series} =
      attrs
      |> Enum.into(%{
        name: "some name",
        published_at: ~D[2022-08-17]
      })
      |> ComicBookManager.Comics.create_series()

    series
  end

  @doc """
  Generate a universe.
  """
  def universe_fixture(attrs \\ %{}) do
    {:ok, universe} =
      attrs
      |> Enum.into(%{
        first_published_at: ~D[2022-08-17],
        name: "some name"
      })
      |> ComicBookManager.Comics.create_universe()

    universe
  end
end
