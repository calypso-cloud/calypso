defmodule Calypso.Repo do
  use Ecto.Repo,
    otp_app: :calypso,
    adapter: Ecto.Adapters.Postgres
end
