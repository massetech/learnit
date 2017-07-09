defmodule Learnit.MemoryTest do
  use Learnit.ModelCase

  alias Learnit.Memory

  @valid_attrs %{status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Memory.changeset(%Memory{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Memory.changeset(%Memory{}, @invalid_attrs)
    refute changeset.valid?
  end
end
