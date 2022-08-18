defmodule ComicBookManager.Repo.Migrations.CreateSeries do
  use Ecto.Migration

  def change do
    create table(:series, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :published_at, :date
      add :universe_id, references(:universes, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:series, [:universe_id])
  end
end
