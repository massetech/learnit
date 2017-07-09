defmodule Learnit.ItemController do
  use Learnit.Web, :controller
  require Logger
  alias Learnit.Item
  alias Learnit.Topic
  alias Learnit.Classroom
  plug :load_selects

  def index(conn, _params) do
    items =
      Item
      |> Repo.all()
      |> Repo.preload(:topic)
      |> Repo.preload(topic: :classroom)
    Logger.debug "Var items: #{inspect(items)}"
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
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Repo.get!(Item, id)
      |> Repo.preload(:topic)
      |> Repo.preload(topic: :classroom)
    render(conn, "show.html", item: item)
    Logger.debug "Var item: #{inspect(item)}"
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

  defp load_selects(conn, _params) do
    # Assigns selects functions associated from repo
    assign(conn, :topics, Repo.all(from(c in Topic, select: {c.title, c.id})))
  end
end
