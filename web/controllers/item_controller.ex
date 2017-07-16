defmodule Learnit.ItemController do
  use Learnit.Web, :controller
  alias Learnit.{Classroom, Topic, Item, List, Itemlist}
  plug :load_topics when action in [:index, :edit]
  plug :load_lists when action in [:show]

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

  def index(conn, _params) do
    changeset = Item.changeset(%Item{})
    items =
      Item
      |> Repo.all()
      |> Repo.preload([:topic, :lists, topic: :classroom])
    render(conn, "index.html", items: items, changeset: changeset)
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
        render(conn, "new.html", changeset: changeset)
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
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: item_path(conn, :show, item))
      {:error, changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Repo.get!(Item, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: item_path(conn, :index))
  end

  defp load_topics(conn, _params) do
    assign(conn, :topics, Repo.all(from(t in Topic, select: {t.title, t.id})))
  end
  defp load_lists(conn, _params) do
    assign(conn, :lists, Repo.all(from(l in List, select: {l.title, l.id})))
  end
end
