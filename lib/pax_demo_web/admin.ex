defmodule PaxDemoWeb.Admin do
  use Pax.Admin, router: PaxDemoWeb.Router
  use Phoenix.Component

  # def render_index(assigns) do
  #   ~H"""
  #   <h1 class="text-2xl mb-3 flex justify-between">Labels <small>PaxDemoWeb.Admin</small></h1>
  #   <Pax.Index.Components.index pax_fields={@pax_fields} objects={@objects} />
  #   """
  # end

  config title: "Pax Demo Admin"

  resource :label, "Labels", PaxDemoWeb.Admin.Label

  section :library, "Music Library" do
    resource :label, "Labels", PaxDemoWeb.Admin.Label
    resource :artist, "Artists", PaxDemoWeb.Admin.Artist
    resource :album, "Albums", PaxDemoWeb.Admin.Album
  end

  section :library2, "Music Library Two" do
    resource :album, "Albums", PaxDemoWeb.Admin.Album
  end
end
