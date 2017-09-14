defmodule Learnit.AssociateList do
  use Learnit.Web, :model
  alias Learnit.{List, Item, Repo}

  embedded_schema do
    field :list_id
    field :item_id
  end

  @required_fields ~w(list_id item_id)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end

  def to_multi(params \\ %{}) do
    Ecto.Multi.new
      |> Ecto.Multi.insert(:list, list_changeset(params))
      |> Ecto.Multi.insert(:item, item_changeset(params))
  end

  defp list_changeset(%{"list_id" => list_id}) do
    List.changeset %List{id: list_id}
  end

  defp item_changeset(%{"item_id" => item_id}) do
    Item.changeset %Item{id: item_id}
  end

end
