defmodule Learnit.Membership do
  use Learnit.Web, :model

    schema "memberships" do
      belongs_to :user, Learnit.User
      belongs_to :list, Learnit.List
      has_many :memorys, Learnit.Memory, on_delete: :delete_all
      timestamps()
    end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:user_id, :list_id])
      |> validate_required([:user_id, :list_id])
      |> cast_assoc(:memorys, required: true)
    end
end
