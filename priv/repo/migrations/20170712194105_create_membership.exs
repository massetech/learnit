defmodule Learnit.Repo.Migrations.CreateMembership do
  use Ecto.Migration

  def change do
    create table(:memberships) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :list_id, references(:lists, on_delete: :delete_all)

      timestamps()
    end
    create index(:memberships, [:user_id])
    create index(:memberships, [:list_id])

  end
end
