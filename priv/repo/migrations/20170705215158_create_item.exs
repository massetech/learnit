defmodule Learnit.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :topic_id, references(:topics, on_delete: :delete_all)
      add :level, :integer
      add :kind, :string
      add :question, :string
      add :description, :string

      timestamps()
    end
    create index(:items, [:topic_id])

  end
end
