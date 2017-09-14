defmodule Learnit.Classroom do
  use Learnit.Web, :model

  @derive {Poison.Encoder, only: [:title]}

  schema "classrooms" do
    field :title, :string
    has_many :topics, Learnit.Topic, on_delete: :delete_all
    has_many :lists, Learnit.List, on_delete: :delete_all
    has_many :items, through: [:topics, :items]
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
