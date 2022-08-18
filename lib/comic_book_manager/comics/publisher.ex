defmodule ComicBookManager.Comics.Publisher do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "publishers" do
    field :created_at, :date
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(publisher, attrs) do
    publisher
    |> cast(attrs, [:name, :created_at])
    |> validate_required([:name, :created_at])
  end
end
