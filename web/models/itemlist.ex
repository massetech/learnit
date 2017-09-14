defmodule Learnit.Itemlist do
  use Learnit.Web, :model

  schema "itemlists" do
    belongs_to :item, Learnit.Item
    belongs_to :list, Learnit.List
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:list_id, :item_id])
    |> validate_required([:list_id, :item_id])
    |> unique_constraint(:item_id_list_id) # Dont forget to put constraint on table too
  end

end
