defmodule Learnit.MembershipCommander do
  use Drab.Commander
  # alias Learnit.{Membership}

    onload :page_loaded

    def page_loaded(socket) do
      #initial = peek(socket, :memberships) # Load assign
      put_store(socket, :memberships, "test ok") # Store assign in localStorage
      current = get_store(socket, :memberships) # Retrieve assign from localStorage
      IO.inspect(current)
      #poke socket, test: "This page has been drabbed"
      #poke socket, get_store(socket, :place)
    end

  #current = get_store(socket, :memberships) # Retrieve assign from localStorage
  #poke socket, get_store(socket, :place) # Update
  # Learnit.MembershipView, "test.html",

end
