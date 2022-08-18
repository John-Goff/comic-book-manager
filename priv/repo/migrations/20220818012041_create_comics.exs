defmodule ComicBookManager.Repo.Migrations.CreateComics do
  use Ecto.Migration

  def change do
    create table(:comics, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :published_at, :date
      add :read_percentage, :integer
      add :issue_number, :integer
      add :series_id, references(:series, on_delete: :nothing, type: :binary_id)
      add :publisher_id, references(:publishers, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:comics, [:series_id])
    create index(:comics, [:publisher_id])
  end
end
