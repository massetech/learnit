defmodule Learnit.Topic do
  use Learnit.Web, :model

  schema "topics" do
    field :title, :string
    belongs_to :classroom, Learnit.Classroom
    has_many :items, Learnit.Item, on_delete: :delete_all
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
