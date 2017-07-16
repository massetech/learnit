defmodule Learnit.List do
  use Learnit.Web, :model

  schema "lists" do
    field :title, :string
    belongs_to :classroom, Learnit.Classroom
    has_many :itemlists, Learnit.Itemlist
    many_to_many :items, Learnit.Item, join_through: Learnit.Itemlist
    #many_to_many :topics, Learnit.Topic, join_through: Learnit.Item
    has_many :memberships, Learnit.Membership
    many_to_many :users, Learnit.User, join_through: Learnit.Membership
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :classroom_id])
    |> foreign_key_constraint(:classroom_id)
    |> validate_required([:title])
    |> cast_assoc(:itemlists, required: true)
  end

  # def registered() do
  #   from c in Learnit.List,
  #   where: c.user_id == 1 #Coherence.current_user(conn).id
  # end

end
