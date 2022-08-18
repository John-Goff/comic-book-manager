defmodule ComicBookManager.Comics.Universe do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "universes" do
    field :first_published_at, :date
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(universe, attrs) do
    universe
    |> cast(attrs, [:name, :first_published_at])
    |> validate_required([:name, :first_published_at])
  end
end
