defmodule DuelsWeb.Router do
  use DuelsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DuelsWeb do
    pipe_through :api
  end
end
