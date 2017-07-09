defmodule Learnit.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :topic_id, references(:topics, on_delete: :delete_all)
      add :level, :integer
      add :dim0, :string
      add :dim1, :string
      add :dim2, :string
      add :dim3, :string
      add :dim4, :string

      timestamps()
    end
    create index(:items, [:topic_id])

  end
end
