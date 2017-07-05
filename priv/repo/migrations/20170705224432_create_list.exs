defmodule Learnit.Repo.Migrations.CreateList do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :user_id, references(:users, on_delete: :nothing)
      add :topic_id, references(:topics, on_delete: :nothing)

      timestamps()
    end
    create index(:lists, [:user_id])
    create index(:lists, [:topic_id])

  end
end
