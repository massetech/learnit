defmodule Learnit.Memory do
  use Learnit.Web, :model

  @derive {Poison.Encoder, only: [:item, :id, :status]}

    schema "memorys" do
      field :status, :string
      belongs_to :membership, Learnit.Membership
      belongs_to :item, Learnit.Item

      timestamps()
    end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
      def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:status, :membership_id, :item_id])
        #|> foreign_key_constraint([:membership_id, :item_id])  # Dont use that !
        |> unique_constraint(:membership_id_item_id) # Dont forget to put constraint on table too
        |> validate_required([:item_id]) # Cannot use :membership_id with cast_assoc
      end
end
