defmodule Learnit.ClassroomControllerTest do
  use Learnit.ConnCase

  alias Learnit.Classroom
  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, classroom_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing classrooms"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, classroom_path(conn, :new)
    assert html_response(conn, 200) =~ "New classroom"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, classroom_path(conn, :create), classroom: @valid_attrs
    assert redirected_to(conn) == classroom_path(conn, :index)
    assert Repo.get_by(Classroom, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, classroom_path(conn, :create), classroom: @invalid_attrs
    assert html_response(conn, 200) =~ "New classroom"
  end

  test "shows chosen resource", %{conn: conn} do
    classroom = Repo.insert! %Classroom{}
    conn = get conn, classroom_path(conn, :show, classroom)
    assert html_response(conn, 200) =~ "Show classroom"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, classroom_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    classroom = Repo.insert! %Classroom{}
    conn = get conn, classroom_path(conn, :edit, classroom)
    assert html_response(conn, 200) =~ "Edit classroom"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    classroom = Repo.insert! %Classroom{}
    conn = put conn, classroom_path(conn, :update, classroom), classroom: @valid_attrs
    assert redirected_to(conn) == classroom_path(conn, :show, classroom)
    assert Repo.get_by(Classroom, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    classroom = Repo.insert! %Classroom{}
    conn = put conn, classroom_path(conn, :update, classroom), classroom: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit classroom"
  end

  test "deletes chosen resource", %{conn: conn} do
    classroom = Repo.insert! %Classroom{}
    conn = delete conn, classroom_path(conn, :delete, classroom)
    assert redirected_to(conn) == classroom_path(conn, :index)
    refute Repo.get(Classroom, classroom.id)
  end
end
