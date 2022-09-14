defmodule DuelsWeb.UserController do
  use DuelsWeb, :controller

  alias Duels.Accounts
  alias Duels.Accounts.User

  action_fallback DuelsWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      user_info(conn, user)
    end
  end

  def signin(conn, %{"username" => username, "password" => password}) do
    with {:ok, %User{} = user } = Accounts.get_by_username(username),
      true <- validate_password(password, user.encrypted_password) do
        user_info(conn, user)
      end
  end

  defp validate_password(password, encrypted_password) do
    Argon2.verify_pass(password, encrypted_password)
  end

  defp user_info(conn, user) do
    with token <- Phoenix.Token.sign(conn, "user auth", user.id) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token})
    end
  end
end
