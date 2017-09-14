defmodule Learnit.Object do
  use Learnit.Web, :model

  schema "objects" do
    field :language, :string
    field :answer, :string
    belongs_to :item, Learnit.Item

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:language, :answer])
    |> validate_required([:language, :answer])
  end
end
