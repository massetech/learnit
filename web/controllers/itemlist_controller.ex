defmodule Learnit.ItemlistController do
  use Learnit.Web, :controller
  alias Learnit.{Itemlist}

  # def index(conn, _params) do
  #   itemlists = Repo.all(Itemlist)
  #   render(conn, "index.html", itemlists: itemlists)
  # end

  # def new(conn, _params) do
  #   changeset = Itemlist.changeset(%Itemlist{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  def create(conn, %{"itemlist" => itemlist_params}) do
    changeset = Itemlist.changeset(%Itemlist{}, itemlist_params)

    case Repo.insert(changeset) do
      {:ok, _itemlist} ->
        conn
        #|> put_flash(:info, "Item was added to the list.")
        |> redirect(to: list_item_path(conn, :select, itemlist_params["list_id"]))
      {:error, changeset} ->
        changeset
        |> IO.inspect()
        |> put_flash(:alert, "Item was not added to the list.")
        |> redirect(to: list_item_path(conn, :select, itemlist_params["list_id"]))
    end
  end

  # def show(conn, %{"id" => id}) do
  #   itemlist = Repo.get!(Itemlist, id)
  #   render(conn, "show.html", itemlist: itemlist)
  # end

  # def edit(conn, %{"id" => id}) do
  #   itemlist = Repo.get!(Itemlist, id)
  #   changeset = Itemlist.changeset(itemlist)
  #   render(conn, "edit.html", itemlist: itemlist, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "itemlist" => itemlist_params}) do
  #   itemlist = Repo.get!(Itemlist, id)
  #   changeset = Itemlist.changeset(itemlist, itemlist_params)
  #
  #   case Repo.update(changeset) do
  #     {:ok, itemlist} ->
  #       conn
  #       |> put_flash(:info, "Itemlist updated successfully.")
  #       |> redirect(to: itemlist_path(conn, :show, itemlist))
  #     {:error, changeset} ->
  #       render(conn, "edit.html", itemlist: itemlist, changeset: changeset)
  #   end
  # end

  def delete(conn, %{"id" => id, "list_id" => list_id}) do
    itemlist = Repo.get!(Itemlist, id)
    Repo.delete!(itemlist)
    conn
    #|> put_flash(:info, "Item removed from the list.")
    |> redirect(to: list_item_path(conn, :select, list_id))
  end
end
