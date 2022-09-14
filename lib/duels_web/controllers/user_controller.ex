defmodule DuelsWeb.UserController do
  use DuelsWeb, :controller

  alias Duels.Accounts
  alias Duels.Accounts.User

  action_fallback DuelsWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> user_info(user)
    end
  end

  def signin(conn, %{"username" => username, "password" => password}) do
    with {:ok, %User{} = user } = Accounts.get_by_username(username),
      true <- validate_password(password, user.encrypted_password) do
      conn
      |> put_status(200)
      |> user_info(user)
      end
  end

  def me(conn, %{"token" => token}) do
    me_internal(conn, token)
  end

  def me(conn, _params) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization") do
      me_internal(conn, token)
    end
  end

  defp me_internal(conn, token) do
    IO.puts(token)
    with {:ok, id} <- Phoenix.Token.verify(conn, "user auth", token),
      %User{} = user <- Duels.Repo.get(User, id) do
      conn
      |> put_status(200)
      |> user_info(user)
    end
  end

  defp validate_password(password, encrypted_password) do
    Argon2.verify_pass(password, encrypted_password)
  end

  defp user_info(conn, user) do
    with token <- Phoenix.Token.sign(conn, "user auth", user.id) do
      conn
      |> put_secure_browser_headers()
      |> render("user.json", %{user: user, token: token})
    end
  end
end
