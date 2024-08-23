# Default imports and aliases
import Ecto.Query, only: [from: 1, from: 2]

alias PaxDemoWeb.Endpoint
alias PaxDemo.Repo

alias PaxDemo.Library
alias PaxDemo.Library.{Label, Artist, Album}

# iex configuration
IEx.configure(
  inspect: [
    custom_options: [sort_maps: true]
  ]
)
