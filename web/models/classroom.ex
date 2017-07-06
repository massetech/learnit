defmodule Learnit.Classroom do
  use Learnit.Web, :model

  schema "classrooms" do
    field :title, :string
    has_many :topics, Learnit.Classroom
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
