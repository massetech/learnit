defmodule Learnit.ListController do
  use Learnit.Web, :controller
  alias Learnit.{List, Classroom, AssociateList, User, Membership, Item, Topic, Itemlist}
  plug :load_selects when action in [:new, :edit]

  def index(conn, _params) do
    user_id = Coherence.current_user(conn).id
    query = from u in Learnit.User, where: u.id == ^user_id
    lists =
      List
      |> Repo.all()
      |> Repo.preload([:classroom, :memberships, :items, users: query])
      |> IO.inspect()
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
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    #changeset = AssociateList.changeset(%AssociateList{})
    #redirect conn, to: list_path(conn, :index)
    list = List
      |> query_items(id)
      |> Repo.get(id)
      |> Repo.preload([:classroom, :users])
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
        |> redirect(to: list_path(conn, :show, list))
      {:error, changeset} ->
        render(conn, "edit.html", list: list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Repo.get!(List, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(list)

    conn
    |> put_flash(:info, "List deleted successfully.")
    |> redirect(to: list_path(conn, :index))
  end

  defp load_selects(conn, _params) do
    # Assigns selects functions associated from repo
    assign(conn, :classrooms, Repo.all(from(c in Classroom, select: {c.title, c.id})))
  end

  defp query_items(_, id) do
    # Check that there is at least one item linked to the list
    case Repo.get_by(Itemlist, list_id: id) do
      nil ->
        from l in List,
        preload: [:items]
      _ ->
        # Load query to get items and itemlists of the list
        from l in List,
        join: i in assoc(l, :items),
        join: il in assoc(l, :itemlists), on: il.list_id == l.id,
        where: i.id == il.item_id,
        preload: [items: {i, itemlists: il}]
    end
  end
end
