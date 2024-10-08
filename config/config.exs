# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :pax_demo,
  ecto_repos: [PaxDemo.Repo]

# Configures the endpoint
config :pax_demo, PaxDemoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: PaxDemoWeb.ErrorHTML, json: PaxDemoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PaxDemo.PubSub,
  live_view: [signing_salt: "H3Xq7vc5"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.6",
  default: [
    args: ~w( --config=tailwind.config.js --input=css/app.css --output=../priv/static/assets/app.css ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :dart_sass,
  version: "1.69.2",
  default: [
    args: ~w(css/bootstrap.scss ../priv/static/assets/bootstrap.css),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configure tailwind (the version is required)
# config :tailwind,
#   version: "3.3.2",
#   default: [
#     args: ~w(
#       --config=tailwind.config.js
#       --input=css/app.css
#       --output=../priv/static/assets/app.css
#     ),
#     cd: Path.expand("../assets", __DIR__)
#   ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure Flop
config :flop, repo: PaxDemo.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :live_admin, ecto_repo: PaxDemo.Repo
