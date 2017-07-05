defmodule Learnit.Repo.Migrations.CreateClassroom do
  use Ecto.Migration

  def change do
    create table(:classrooms) do
      add :title, :string

      timestamps()
    end

  end
end
