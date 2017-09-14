defmodule Learnit.ObjectTest do
  use Learnit.ModelCase

  alias Learnit.Object

  @valid_attrs %{answer: "some content", language: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Object.changeset(%Object{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Object.changeset(%Object{}, @invalid_attrs)
    refute changeset.valid?
  end
end
