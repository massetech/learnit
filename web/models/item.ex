defmodule Learnit.Item do
  use Learnit.Web, :model

  schema "items" do
    field :level, :integer
    field :dim0, :string
    field :dim1, :string
    field :dim2, :string
    field :dim3, :string
    field :dim4, :string
    belongs_to :topic, Learnit.Topic
    has_many :itemlists, Learnit.Itemlist
    many_to_many :lists, Learnit.List, join_through: Learnit.Itemlist
    has_many :memorys, Learnit.Memory
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:level, :dim0, :dim1, :dim2, :dim3, :dim4, :topic_id])
    |> foreign_key_constraint(:topic_id)
    |> validate_required([:level, :dim0, :dim1, :dim2, :dim3, :dim4])
  end
end
