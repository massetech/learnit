defmodule Learnit.Repo.Migrations.CreateObject do
  use Ecto.Migration

  def change do
    create table(:objects) do
      add :language, :string
      add :answer, :string
      add :item_id, references(:items, on_delete: :nothing)

      timestamps()
    end
    create index(:objects, [:item_id])

  end
end
