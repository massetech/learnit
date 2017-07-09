defmodule Learnit.MemoryController do
  use Learnit.Web, :controller

  alias Learnit.Memory

  def index(conn, _params) do
    memories = Repo.all(Memory)
    render(conn, "index.html", memories: memories)
  end

  def new(conn, _params) do
    changeset = Memory.changeset(%Memory{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"memory" => memory_params}) do
    changeset = Memory.changeset(%Memory{}, memory_params)

    case Repo.insert(changeset) do
      {:ok, _memory} ->
        conn
        |> put_flash(:info, "Memory created successfully.")
        |> redirect(to: memory_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    memory = Repo.get!(Memory, id)
    render(conn, "show.html", memory: memory)
  end

  def edit(conn, %{"id" => id}) do
    memory = Repo.get!(Memory, id)
    changeset = Memory.changeset(memory)
    render(conn, "edit.html", memory: memory, changeset: changeset)
  end

  def update(conn, %{"id" => id, "memory" => memory_params}) do
    memory = Repo.get!(Memory, id)
    changeset = Memory.changeset(memory, memory_params)

    case Repo.update(changeset) do
      {:ok, memory} ->
        conn
        |> put_flash(:info, "Memory updated successfully.")
        |> redirect(to: memory_path(conn, :show, memory))
      {:error, changeset} ->
        render(conn, "edit.html", memory: memory, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    memory = Repo.get!(Memory, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(memory)

    conn
    |> put_flash(:info, "Memory deleted successfully.")
    |> redirect(to: memory_path(conn, :index))
  end
end
