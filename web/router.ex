defmodule Learnit.Router do
  use Learnit.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Learnit do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/classrooms", ClassroomController
    resources "/topics", TopicController
    resources "/items", ItemController

    scope "/user", User do
      get "/train", UserController, :train
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Learnit do
  #   pipe_through :api
  # end
end
