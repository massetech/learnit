defmodule Learnit.MemoryControllerTest do
  use Learnit.ConnCase

  alias Learnit.Memory
  @valid_attrs %{status: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, memory_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing memories"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, memory_path(conn, :new)
    assert html_response(conn, 200) =~ "New memory"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, memory_path(conn, :create), memory: @valid_attrs
    assert redirected_to(conn) == memory_path(conn, :index)
    assert Repo.get_by(Memory, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, memory_path(conn, :create), memory: @invalid_attrs
    assert html_response(conn, 200) =~ "New memory"
  end

  test "shows chosen resource", %{conn: conn} do
    memory = Repo.insert! %Memory{}
    conn = get conn, memory_path(conn, :show, memory)
    assert html_response(conn, 200) =~ "Show memory"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, memory_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    memory = Repo.insert! %Memory{}
    conn = get conn, memory_path(conn, :edit, memory)
    assert html_response(conn, 200) =~ "Edit memory"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    memory = Repo.insert! %Memory{}
    conn = put conn, memory_path(conn, :update, memory), memory: @valid_attrs
    assert redirected_to(conn) == memory_path(conn, :show, memory)
    assert Repo.get_by(Memory, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    memory = Repo.insert! %Memory{}
    conn = put conn, memory_path(conn, :update, memory), memory: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit memory"
  end

  test "deletes chosen resource", %{conn: conn} do
    memory = Repo.insert! %Memory{}
    conn = delete conn, memory_path(conn, :delete, memory)
    assert redirected_to(conn) == memory_path(conn, :index)
    refute Repo.get(Memory, memory.id)
  end
end
