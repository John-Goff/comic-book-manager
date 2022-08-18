defmodule ComicBookManager.Comics do
  @moduledoc """
  The Comics context.
  """

  import Ecto.Query, warn: false
  alias ComicBookManager.Repo

  alias ComicBookManager.Comics.Comic

  @doc """
  Returns the list of comics.

  ## Examples

      iex> list_comics()
      [%Comic{}, ...]

  """
  def list_comics do
    Repo.all(Comic)
  end

  @doc """
  Gets a single comic.

  Raises `Ecto.NoResultsError` if the Comic does not exist.

  ## Examples

      iex> get_comic!(123)
      %Comic{}

      iex> get_comic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comic!(id), do: Repo.get!(Comic, id)

  @doc """
  Creates a comic.

  ## Examples

      iex> create_comic(%{field: value})
      {:ok, %Comic{}}

      iex> create_comic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comic(attrs \\ %{}) do
    %Comic{}
    |> Comic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comic.

  ## Examples

      iex> update_comic(comic, %{field: new_value})
      {:ok, %Comic{}}

      iex> update_comic(comic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comic(%Comic{} = comic, attrs) do
    comic
    |> Comic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comic.

  ## Examples

      iex> delete_comic(comic)
      {:ok, %Comic{}}

      iex> delete_comic(comic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comic(%Comic{} = comic) do
    Repo.delete(comic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comic changes.

  ## Examples

      iex> change_comic(comic)
      %Ecto.Changeset{data: %Comic{}}

  """
  def change_comic(%Comic{} = comic, attrs \\ %{}) do
    Comic.changeset(comic, attrs)
  end

  alias ComicBookManager.Comics.Publisher

  @doc """
  Returns the list of publishers.

  ## Examples

      iex> list_publishers()
      [%Publisher{}, ...]

  """
  def list_publishers do
    Repo.all(Publisher)
  end

  @doc """
  Gets a single publisher.

  Raises `Ecto.NoResultsError` if the Publisher does not exist.

  ## Examples

      iex> get_publisher!(123)
      %Publisher{}

      iex> get_publisher!(456)
      ** (Ecto.NoResultsError)

  """
  def get_publisher!(id), do: Repo.get!(Publisher, id)

  @doc """
  Creates a publisher.

  ## Examples

      iex> create_publisher(%{field: value})
      {:ok, %Publisher{}}

      iex> create_publisher(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_publisher(attrs \\ %{}) do
    %Publisher{}
    |> Publisher.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a publisher.

  ## Examples

      iex> update_publisher(publisher, %{field: new_value})
      {:ok, %Publisher{}}

      iex> update_publisher(publisher, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_publisher(%Publisher{} = publisher, attrs) do
    publisher
    |> Publisher.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a publisher.

  ## Examples

      iex> delete_publisher(publisher)
      {:ok, %Publisher{}}

      iex> delete_publisher(publisher)
      {:error, %Ecto.Changeset{}}

  """
  def delete_publisher(%Publisher{} = publisher) do
    Repo.delete(publisher)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking publisher changes.

  ## Examples

      iex> change_publisher(publisher)
      %Ecto.Changeset{data: %Publisher{}}

  """
  def change_publisher(%Publisher{} = publisher, attrs \\ %{}) do
    Publisher.changeset(publisher, attrs)
  end

  alias ComicBookManager.Comics.Series

  @doc """
  Returns the list of series.

  ## Examples

      iex> list_series()
      [%Series{}, ...]

  """
  def list_series do
    Repo.all(Series)
  end

  @doc """
  Gets a single series.

  Raises `Ecto.NoResultsError` if the Series does not exist.

  ## Examples

      iex> get_series!(123)
      %Series{}

      iex> get_series!(456)
      ** (Ecto.NoResultsError)

  """
  def get_series!(id), do: Repo.get!(Series, id)

  @doc """
  Creates a series.

  ## Examples

      iex> create_series(%{field: value})
      {:ok, %Series{}}

      iex> create_series(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_series(attrs \\ %{}) do
    %Series{}
    |> Series.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a series.

  ## Examples

      iex> update_series(series, %{field: new_value})
      {:ok, %Series{}}

      iex> update_series(series, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_series(%Series{} = series, attrs) do
    series
    |> Series.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a series.

  ## Examples

      iex> delete_series(series)
      {:ok, %Series{}}

      iex> delete_series(series)
      {:error, %Ecto.Changeset{}}

  """
  def delete_series(%Series{} = series) do
    Repo.delete(series)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking series changes.

  ## Examples

      iex> change_series(series)
      %Ecto.Changeset{data: %Series{}}

  """
  def change_series(%Series{} = series, attrs \\ %{}) do
    Series.changeset(series, attrs)
  end

  alias ComicBookManager.Comics.Universe

  @doc """
  Returns the list of universes.

  ## Examples

      iex> list_universes()
      [%Universe{}, ...]

  """
  def list_universes do
    Repo.all(Universe)
  end

  @doc """
  Gets a single universe.

  Raises `Ecto.NoResultsError` if the Universe does not exist.

  ## Examples

      iex> get_universe!(123)
      %Universe{}

      iex> get_universe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_universe!(id), do: Repo.get!(Universe, id)

  @doc """
  Creates a universe.

  ## Examples

      iex> create_universe(%{field: value})
      {:ok, %Universe{}}

      iex> create_universe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_universe(attrs \\ %{}) do
    %Universe{}
    |> Universe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a universe.

  ## Examples

      iex> update_universe(universe, %{field: new_value})
      {:ok, %Universe{}}

      iex> update_universe(universe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_universe(%Universe{} = universe, attrs) do
    universe
    |> Universe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a universe.

  ## Examples

      iex> delete_universe(universe)
      {:ok, %Universe{}}

      iex> delete_universe(universe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_universe(%Universe{} = universe) do
    Repo.delete(universe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking universe changes.

  ## Examples

      iex> change_universe(universe)
      %Ecto.Changeset{data: %Universe{}}

  """
  def change_universe(%Universe{} = universe, attrs \\ %{}) do
    Universe.changeset(universe, attrs)
  end
end
