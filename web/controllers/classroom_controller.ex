defmodule Learnit.ClassroomController do
  use Learnit.Web, :controller
  alias Learnit.{Classroom, Topic, List}

  def index(conn, _params) do
    classrooms =
      Classroom
      |> Repo.all()
      |> Repo.preload([:lists, :topics]) # [:topics, :lists]
      |> IO.inspect()
    render(conn, "index.html", classrooms: classrooms)
  end

  def new(conn, _params) do
    changeset = Classroom.changeset(%Classroom{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"classroom" => classroom_params}) do
    changeset = Classroom.changeset(%Classroom{}, classroom_params)

    case Repo.insert(changeset) do
      {:ok, _classroom} ->
        conn
        |> put_flash(:info, "Classroom created successfully.")
        |> redirect(to: classroom_path(conn, :index))
      {:error, changeset} ->
        #render(conn, "new.html", changeset: changeset)
        conn
        |> put_flash(:alert, "Classroom was not created.")
        |> redirect(to: classroom_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}) do
    classroom = Repo.get!(Classroom, id)
    render(conn, "show.html", classroom: classroom)
  end

  def edit(conn, %{"id" => id}) do
    classroom = Repo.get!(Classroom, id)
    changeset = Classroom.changeset(classroom)
    render(conn, "edit.html", classroom: classroom, changeset: changeset)
  end

  def update(conn, %{"id" => id, "classroom" => classroom_params}) do
    classroom = Repo.get!(Classroom, id)
    changeset = Classroom.changeset(classroom, classroom_params)

    case Repo.update(changeset) do
      {:ok, classroom} ->
        conn
        |> put_flash(:info, "Classroom updated successfully.")
        |> redirect(to: classroom_path(conn, :index))
      {:error, changeset} ->
        #render(conn, "edit.html", classroom: classroom, changeset: changeset)
        conn
        |> put_flash(:alert, "Classroom was not updated.")
        |> redirect(to: classroom_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    classroom = Repo.get!(Classroom, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(classroom)

    conn
    |> put_flash(:info, "Classroom deleted successfully.")
    |> redirect(to: classroom_path(conn, :index))
  end
end
