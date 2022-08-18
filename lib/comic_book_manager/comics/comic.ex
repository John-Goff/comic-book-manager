defmodule ComicBookManager.Comics.Comic do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comics" do
    field :issue_number, :integer
    field :published_at, :date
    field :read_percentage, :integer
    field :series_id, :binary_id
    field :publisher_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(comic, attrs) do
    comic
    |> cast(attrs, [:published_at, :read_percentage, :issue_number])
    |> validate_required([:published_at, :read_percentage, :issue_number])
  end
end
