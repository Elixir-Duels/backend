defmodule DuelsWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use DuelsWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(DuelsWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(DuelsWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(DuelsWeb.ErrorView, :"401")
  end

  def call(conn, e) do
    try do
      IO.puts(e)
    rescue _ ->
      IO.puts("can't print error")
    end
    conn
    |> put_status(:internal_server_error)
    |> put_view(DuelsWeb.ErrorView)
    |> render(:"503")
  end
end
