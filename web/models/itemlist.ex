defmodule Learnit.Itemlist do
  use Learnit.Web, :model

  schema "itemlists" do
    belongs_to :item, Learnit.Item
    belongs_to :list, Learnit.List

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
