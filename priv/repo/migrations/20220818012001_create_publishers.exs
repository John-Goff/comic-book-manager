defmodule ComicBookManager.Repo.Migrations.CreatePublishers do
  use Ecto.Migration

  def change do
    create table(:publishers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :created_at, :date

      timestamps()
    end
  end
end
