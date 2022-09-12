defmodule Duels.Repo do
  use Ecto.Repo,
    otp_app: :duels,
    adapter: Ecto.Adapters.Postgres
end
