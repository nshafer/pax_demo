defmodule PaxDemo.Repo do
  use Ecto.Repo,
    otp_app: :pax_demo,
    adapter: Ecto.Adapters.Postgres
end
