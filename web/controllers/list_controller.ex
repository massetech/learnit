defmodule Learnit.ListController do
  use Learnit.Web, :controller
  alias Learnit.{List, Classroom, User, Membership, Item, Topic, Itemlist}
  #AssociateList,
  plug :load_selects when action in [:new, :edit]

  def index(conn, _params) do
    user_id = Coherence.current_user(conn).id
    query = from u in Learnit.User, where: u.id == ^user_id
    lists =
      List
      |> Repo.all()
      |> Repo.preload([:classroom, :memberships, :items, users: query])
      #|> IO.inspect()
    changeset = Membership.changeset(%Membership{})
    render(conn, "index.html", lists: lists, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = List.changeset(%List{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"list" => list_params}) do
    changeset = List.changeset(%List{}, list_params)

    case Repo.insert(changeset) do
      {:ok, _list} ->
        conn
        |> put_flash(:info, "List created successfully.")
        |> redirect(to: list_path(conn, :index))
      {:error, changeset} ->
        #render(conn, "new.html", changeset: changeset)
        conn
        |> put_flash(:alert, "List was not created.")
        |> redirect(to: list_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}) do
    list = List
      |> Repo.get(id)
      #|> load_itemlists(list_id)
      |> Repo.preload([:classroom, :users, items: :itemlists])
      |> IO.inspect()
    render(conn, "show.html", list: list)
  end

  def edit(conn, %{"id" => id}) do
    list = Repo.get!(List, id)
    changeset = List.changeset(list)
    render(conn, "edit.html", list: list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Repo.get!(List, id)
    changeset = List.changeset(list, list_params)

    case Repo.update(changeset) do
      {:ok, list} ->
        conn
        |> put_flash(:info, "List updated successfully.")
        |> redirect(to: list_path(conn, :index))
      {:error, changeset} ->
        #render(conn, "edit.html", list: list, changeset: changeset)
        conn
        |> put_flash(:alert, "List was not updated.")
        |> redirect(to: list_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Repo.get!(List, id)
    Repo.delete!(list)
    conn
    |> put_flash(:info, "List deleted successfully.")
    |> redirect(to: list_path(conn, :index))
  end

  defp load_selects(conn, _params) do
    # Assigns selects functions associated from repo
    assign(conn, :classrooms, Repo.all(from(c in Classroom, select: {c.title, c.id})))
  end

  defp load_itemlists(_, list_id) do
    # Check that there is at least one item linked to the list
    itemlists = from(i in Itemlist, where: i.list_id == ^list_id)
      |> Repo.all()
    #case Repo.get(Itemlist, list_id: id) do
    case itemlists do
      nil ->  # There is no itemlist : preload items normaly
        from l in List,
        preload: [:items]
      _ ->  # There is itemlist : preload items and itemlists
        from l in List,
        join: i in assoc(l, :items),
        join: il in assoc(l, :itemlists), on: il.list_id == l.id,
        where: i.id == il.item_id,
        preload: [items: {i, itemlists: il}]
    end
  end
end
