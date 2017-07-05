defmodule Learnit.Topic do
  use Learnit.Web, :model

  schema "topics" do
    field :title, :string
    belongs_to :classroom, Learnit.Classroom

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
