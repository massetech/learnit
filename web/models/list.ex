defmodule Learnit.List do
  use Learnit.Web, :model

  schema "lists" do
    field :title, :string
    belongs_to :classroom, Learnit.Classroom
    has_many :itemlists, Learnit.Itemlist
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :classroom_id])
    |> foreign_key_constraint(:classroom_id)
    |> validate_required([:title])
  end
end
