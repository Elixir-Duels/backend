defmodule DuelsWeb.UserSocket do
  use Phoenix.Socket

  def connect(params, socket, _connect_info) do
    token = params["token"]
    with {:ok, user_id} = Phoenix.Token.verify(socket, "user auth", token) do
      {:ok, assign(socket, :user_id, user_id)}
    end
  end

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"

  ## Channels
  channel "chat:*", DuelsWeb.ChatChannel
end
