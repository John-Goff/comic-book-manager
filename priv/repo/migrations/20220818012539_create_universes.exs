defmodule ComicBookManager.Repo.Migrations.CreateUniverses do
  use Ecto.Migration

  def change do
    create table(:universes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :first_published_at, :date

      timestamps()
    end
  end
end
