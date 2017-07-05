defmodule Learnit.ClassroomTest do
  use Learnit.ModelCase

  alias Learnit.Classroom

  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Classroom.changeset(%Classroom{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Classroom.changeset(%Classroom{}, @invalid_attrs)
    refute changeset.valid?
  end
end
