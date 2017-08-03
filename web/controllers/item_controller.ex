defmodule Learnit.ItemController do
  use Learnit.Web, :controller
  alias Learnit.{Classroom, Topic, Item, List, Itemlist}
  # plug :load_topics when action in [:index, :edit]
  # plug :load_lists when action in [:show]
  plug :load_selects when action in [:new, :edit]

  # Module to import Items from CSV
  def import(conn, %{"item" => item_params}) do
    item_params["file"].path
    |> File.stream!()
    |> CSV.decode(separator: ?;, headers: [:level, :dim0, :dim1, :dim2, :dim3, :dim4])
    |> Enum.map(fn (item) ->
      {:ok, fields} = item
      Item.changeset(%Item{}, %{topic_id: item_params["topic_id"], level: fields.level, dim0: fields.dim0, dim1: fields.dim1, dim2: fields.dim2, dim3: fields.dim3, dim4: fields.dim4})
      |> Repo.insert
    end)
    |> Enum.filter(fn
      {:error, _} -> true
      _ -> false
    end)
    |> case do
      [] ->
        conn
        |> put_flash(:info, "Imported without error")
        |> redirect(to: item_path(conn, :index))
      errors ->
        conn
        |> put_flash(:error, errors)
        |> render("import.html")
    end
  end

    def select(conn, %{"list_id" => list_id}) do
      list = Repo.get!(List, list_id)
      classroom = Repo.get!(Classroom, list.classroom_id)
      list_id = list.id
      query_list  = from l in Learnit.Itemlist, where: l.list_id == ^list_id  # Filter on the list's ID
      items =
        Item
        #|> Item.with_classroom(classroom.id)
        |> Repo.all()
        |> Repo.preload(itemlists: query_list)
        |> Enum.map(&add_changeset(&1, list_id)) # Loop through the items to add changesets if there is no itemlist yet
      render(conn, "select.html", items: items, list: list)
    end

    defp add_changeset(item, list_id) do
      case Enum.count(item.itemlists) do
        0 -> # There is no itemlists yet : we create the changeset
          changeset = Itemlist.changeset(%Itemlist{}, %{item_id: item.id, list_id: list_id})
          item = %Item{item | new_itemlist: changeset}
        _ -> # There is already 1 itemlist : we load the actual itemlist
          actual = Enum.at(item.itemlists, 0) # Remove array
          item = %Item{item | actual_itemlist: actual}
      end
      IO.inspect(item)
    end

  def index(conn, _params) do
    items =
      Item
      |> Repo.all()
      |> Repo.preload([:topic, :lists, topic: :classroom])
    render(conn, "index.html", items: items)
  end

  def new(conn, _params) do
    changeset = Item.changeset(%Item{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item" => item_params}) do
    changeset = Item.changeset(%Item{}, item_params)
    case Repo.insert(changeset) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: item_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Item not created.")
        |> redirect(to: item_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}) do
    item = Repo.get!(Item, id)
      |> Repo.preload([:topic, :lists, topic: :classroom])
      #|> IO.inspect()
    IO.inspect(conn)
    changeset = Itemlist.changeset(%Itemlist{})
    render(conn, "show.html", item: item, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    item = Repo.get!(Item, id)
    changeset = Item.changeset(item)
    render(conn, "edit.html", item: item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Repo.get!(Item, id)
    changeset = Item.changeset(item, item_params)
    case Repo.update(changeset) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: item_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Item not updated.")
        |> redirect(to: item_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Repo.get!(Item, id)
    Repo.delete!(item)
    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: item_path(conn, :index))
  end

  defp load_selects(conn, _params) do
    # Assigns selects functions associated from repo
    assign(conn, :topics, Repo.all(from(t in Topic, select: {t.title, t.id})))
  end

  # defp load_topics(conn, _params) do
  #   assign(conn, :topics, Repo.all(from(t in Topic, select: {t.title, t.id})))
  # end
  # defp load_lists(conn, _params) do
  #   assign(conn, :lists, Repo.all(from(l in List, select: {l.title, l.id})))
  # end
end
