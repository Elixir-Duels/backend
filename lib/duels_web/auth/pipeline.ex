defmodule DuelsWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :duels,
    module: DuelsWeb.Auth.Guardian,
    error_handler: DuelsWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
