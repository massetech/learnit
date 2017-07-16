defmodule Learnit.AssociateListController do
  use Learnit.Web, :controller
  alias Learnit.{List, Item, Itemlist, Repo}

  def new(conn, _params) do
    changeset =
      List.changeset(
        %List{itemlists: [
          %Itemlist{item: %Item{}}]})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"list" => params}) do
    changeset = List.changeset(%List{}, params)
    case Repo.insert(changeset) do
      {:ok, list} ->
        redirect conn, to: list_path(conn, list.id)
      {:error, changeset} ->
        changeset = %{changeset | action: :insert}
        render conn, "new.html", changeset: changeset
    end
  end

end
