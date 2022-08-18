defmodule ComicBookManager.Comics.Series do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "series" do
    field :name, :string
    field :published_at, :date
    field :universe_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(series, attrs) do
    series
    |> cast(attrs, [:name, :published_at])
    |> validate_required([:name, :published_at])
  end
end
