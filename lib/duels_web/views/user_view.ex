defmodule DuelsWeb.UserView do
  use DuelsWeb, :view

  def render("user.json", %{user: user, token: token}) do
    %{
      id: user.id,
      username: user.username,
      token: token
    }
  end
end
