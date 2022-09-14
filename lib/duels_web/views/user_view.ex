defmodule DuelsWeb.UserView do
  use DuelsWeb, :view
  alias DuelsWeb.UserView

  def render("user.json", %{user: user, token: token}) do
    %{
      id: user.id,
      username: user.username,
      token: token
    }
  end
end
