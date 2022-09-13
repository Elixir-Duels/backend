defmodule DuelsWeb.UserSocket do
  use Phoenix.Socket

  def connect(_params, socket, _connect_info) do
    # TODO: Read token here
    user_id = Ecto.UUID.generate()
    {:ok, assign(socket, :user_id, user_id)}
  end

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"

  ## Channels
  channel "chat:*", DuelsWeb.ChatChannel
end
