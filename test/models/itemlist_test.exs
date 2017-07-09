defmodule Learnit.ItemlistTest do
  use Learnit.ModelCase

  alias Learnit.Itemlist

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Itemlist.changeset(%Itemlist{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Itemlist.changeset(%Itemlist{}, @invalid_attrs)
    refute changeset.valid?
  end
end
