defmodule Learnit.Repo.Migrations.CreateClassroom do
  use Ecto.Migration

  def change do
    create table(:classrooms) do
      add :title, :string
      add :dim0_title, :string
      add :dim1_title, :string
      add :dim2_title, :string
      add :dim3_title, :string
      add :dim4_title, :string
      timestamps()
    end

  end
end
