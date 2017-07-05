defmodule Learnit.List do
  use Learnit.Web, :model

  schema "lists" do
    belongs_to :user, Learnit.User
    belongs_to :topic, Learnit.Topic

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
