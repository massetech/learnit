defmodule Learnit.Repo.Migrations.CreateMemory do
  use Ecto.Migration

  def change do
    create table(:memorys) do
      add :status, :string
      add :membership_id, references(:memberships, on_delete: :delete_all)
      add :item_id, references(:items, on_delete: :delete_all)

      timestamps()
    end
    create index(:memorys, [:membership_id])
    create index(:memorys, [:item_id])
    create index(:memorys, [:membership_id, :item_id], unique: true)
  end
end
