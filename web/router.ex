defmodule PhoenixTodosApi.Router do
  use PhoenixTodosApi.Web, :router

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

  scope "/", PhoenixTodosApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", PhoenixTodosApi do
    pipe_through :api
    resources "/todos", TodoController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixTodosApi do
  #   pipe_through :api
  # end
end
