defmodule Learnit.ItemTest do
  use Learnit.ModelCase

  alias Learnit.Item

  @valid_attrs %{dim0: "some content", dim1: "some content", dim2: "some content", dim3: "some content", dim4: "some content", leve: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Item.changeset(%Item{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Item.changeset(%Item{}, @invalid_attrs)
    refute changeset.valid?
  end
end
