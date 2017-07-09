defmodule Learnit.Repo.Migrations.CreateList do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :title, :string
      add :classroom_id, references(:classrooms, on_delete: :delete_all)

      timestamps()
    end
    create index(:lists, [:classroom_id])

  end
end
