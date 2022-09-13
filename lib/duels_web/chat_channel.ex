defmodule DuelsWeb.ChatChannel do
  use Phoenix.Channel

  def join("chat:global", _message, socket) do
    {:ok, socket}
  end

  def join("chat:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"content" => content}, socket) do
    id = Ecto.UUID.generate()
    broadcast!(socket, "new_msg", %{id: id, content: content, author: socket.assigns.user_id})
    {:noreply, socket}
  end
end
