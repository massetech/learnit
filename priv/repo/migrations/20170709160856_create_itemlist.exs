defmodule Learnit.Repo.Migrations.CreateItemlist do
  use Ecto.Migration

  def change do
    create table(:itemlists) do
      add :item_id, references(:items, on_delete: :delete_all)
      add :list_id, references(:lists, on_delete: :delete_all)

      timestamps()
    end
    create index(:itemlists, [:item_id])
    create index(:itemlists, [:list_id])

  end
end
