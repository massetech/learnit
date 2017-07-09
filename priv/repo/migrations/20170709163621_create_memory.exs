defmodule Learnit.Repo.Migrations.CreateMemory do
  use Ecto.Migration

  def change do
    create table(:memories) do
      add :status, :string
      add :user_id, references(:users, on_delete: :delete_all)
      add :itemlist_id, references(:itemlists, on_delete: :delete_all)

      timestamps()
    end
    create index(:memories, [:user_id])
    create index(:memories, [:itemlist_id])

  end
end
