defmodule Learnit.Router do
  use Learnit.Web, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Learnit do
    pipe_through :protected
    get "/", PageController, :index
    resources "/classrooms", ClassroomController
    resources "/topics", TopicController
    resources "/items", ItemController
    resources "/lists", ListController
    resources "/memories", MemoryController
  end

  scope "/" do
    pipe_through :browser # Use the default browser stack
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  # Other scopes may use custom stacks.
  # scope "/api", Learnit do
  #   pipe_through :api
  # end
end
