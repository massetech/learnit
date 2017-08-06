defmodule Learnit.MembershipController do
  use Learnit.Web, :controller
  alias Learnit.{List, Classroom, User, Membership, Item, Topic, Itemlist}
  import PhoenixGon.Controller

  #plug :query_user when action in [:index, :test]

  def index(conn, _params) do
    memberships =
      query_user(conn, _params)
      |> Repo.all
      |> Repo.preload([list: [:classroom, :items]])
    render(conn, "my_lists.html", memberships: memberships)
  end

  def test(conn, _params) do
    memberships =
      query_user(conn, _params)
      |> Repo.all
      |> Repo.preload([list: [:classroom, :items]])
    render(conn, "test.html", memberships: memberships)
  end

  defp query_user(conn, _params) do
    user_id = Coherence.current_user(conn).id
    query = from m in Learnit.Membership, where: m.user_id == ^user_id #Filter on user's memberships
  end

  # def show(conn, %{"id" => id}) do
  #   memorys = Membership
  #     |> Repo.get(id)
  #     |> Repo.preload([:memorys])
  #     |> Map.get(:memorys) # Get the list of memorys
  #     |> Repo.preload([:item]) # Get the list of items
  #     |> IO.inspect()
  #     #conn = put_gon(conn, controller: items)
  #     render(conn, "test.html", memorys: memorys)
  # end

  def create(conn, %{"membership" => params}) do
    memories = []
    params =
      List
      |> Repo.get!(params["list_id"])
      |> Repo.preload(:items)
      |> Map.get(:items) # Get the list of items
      |> Enum.map(&add_items(&1, memories)) # Loop through the list to get list of item ids
      |> (&Map.put(params, "memorys", &1)).() # Add the list to membership params
      |> IO.inspect()
    membership_with_memories = Membership.changeset(%Membership{}, params)
    case Repo.insert(membership_with_memories) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Your list is now available.")
        |> redirect(to: list_path(conn, :index))
      {:error, membership_with_memories} ->
        #Logger.debug("Membership : failed to save membership")
        conn
        |> put_flash(:error, "Membership was not created.")
        |> redirect(to: list_path(conn, :index))
    end
  end

  defp add_items(item, memories) do
    memories ++ %{"item_id" => Kernel.inspect(item.id), "status" => "0"} # Make sure id is a string
  end

  def delete(conn, %{"id" => id}) do
    membership = Repo.get!(Membership, id)
    Repo.delete!(membership)
    conn
    |> put_flash(:info, "The list has been removed.")
    |> redirect(to: list_path(conn, :index))
  end

end
