defmodule Learnit.Memory do
  use Learnit.Web, :model

  schema "memories" do
    field :status, :string
    belongs_to :user, Learnit.User
    belongs_to :itemlist, Learnit.Itemlist

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:status])
    |> validate_required([:status])
  end
end
