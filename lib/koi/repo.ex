defmodule Koi.Repo do
  use Ecto.Repo,
    otp_app: :koi,
    adapter: Ecto.Adapters.Postgres
end
