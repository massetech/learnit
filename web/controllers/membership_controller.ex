defmodule Learnit.MembershipController do
  use Learnit.Web, :controller
  alias Learnit.{Membership, Memory, List}
  require Logger
  import PhoenixGon.Controller

  def index(conn, _params) do
    user_id = Coherence.current_user(conn).id
    query = from m in Learnit.Membership, where: m.user_id == ^user_id #Filter on user's memberships
    memberships =
      query
      |> Repo.all
      |> Repo.preload([:lists, :memorys])
    render(conn, "index.html", memberships: memberships)
  end

  def show(conn, %{"id" => id}) do
    items = Membership
      |> Repo.get(id)
      |> Repo.preload([:memorys])
      #|> Map.get(:memorys) # Get the list of memorys
      conn = put_gon(conn, controller: items)
      render(conn, "test.html", items: items)
  end

  # def new(conn, _params) do
  #   changeset = Membership.changeset(%Membership{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  def create(conn, %{"membership" => membership_params}) do
    #membership = Membership.changeset(%Membership{}, membership_params)
    memories = %{}
    list =
      List
      |> Repo.get!(membership_params["list_id"])
      |> Repo.preload(:items)
      |> Map.get(:items) # Get the list of items
      |> Enum.map(&load_items(&1, memories)) # Loop through the list to get each item
    IO.inspect(memories)
    Map.put(membership_params, :memorys, memories)
    membership_with_memories = Membership.changeset(%Membership{}, membership_params)
    case Repo.insert(membership_with_memories) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Membership created successfully.")
        |> redirect(to: list_path(conn, :index))
      {:error, membership_with_memories} ->
        Logger.debug("Membership : failed to save membership")
        conn
        |> put_flash(:alert, "Membership was not created.")
        |> redirect(to: topic_path(conn, :index))
    end
  end

  defp load_items(item, memories) do
    item
    |> Map.put(memories, :item, item) # Add item to the hash
  end

  def delete(conn, %{"id" => id}) do
    membership = Repo.get!(Membership, id)
    Repo.delete!(membership)
    conn
    |> put_flash(:info, "Membership deleted successfully.")
    |> redirect(to: list_path(conn, :index))
  end

end
