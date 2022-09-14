defmodule DuelsWeb.Router do
  use DuelsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DuelsWeb do
    pipe_through :api
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
  end
end
