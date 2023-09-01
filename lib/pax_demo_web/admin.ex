defmodule PaxDemoWeb.Admin do
  use Pax.Admin.Config, router: PaxDemoWeb.Router
  # use Phoenix.Component

  # def render_index(assigns) do
  #   ~H"""
  #   <h1 class="text-2xl mb-3 flex justify-between">Labels <small>PaxDemoWeb.Admin</small></h1>
  #   <Pax.Index.Components.index pax_fields={@pax_fields} objects={@objects} />
  #   """
  # end

  config title: "Pax Demo Admin"

  resource :label, "Labels", PaxDemoWeb.Admin.LabelResource
  resource :artist, "Artists", PaxDemoWeb.Admin.ArtistResource
  resource :album, "Albums", PaxDemoWeb.Admin.AlbumResource

  # link ("More info", "https://somewhere.com/asdf"

  section :library, "Music Library" do
    resource :label, "Labels", PaxDemoWeb.Admin.LabelResource
    resource :artist, "Artists", PaxDemoWeb.Admin.ArtistResource
    resource :album, "Albums", PaxDemoWeb.Admin.AlbumResource
    resource :album2, "Albums 2", PaxDemoWeb.Admin.AlbumResource
    # page :info, "Information", PaxDemoWeb.Admin.InfoPage
  end

  resource :label2, "Labels", PaxDemoWeb.Admin.LabelResource
  resource :artist2, "Artists", PaxDemoWeb.Admin.ArtistResource
  resource :album2, "Albums", PaxDemoWeb.Admin.AlbumResource

  section :library2, "Music Library Two" do
    resource :album, "Albums Two", PaxDemoWeb.Admin.AlbumResource
  end

  # def config(_params, _session, _socket) do
  #   %{
  #     title: "Pax Demo Admin at Runtime"
  #   }
  # end

  # def resources(_params, _session, _socket) do
  #   [
  #     label: %{title: "Labels", resource: PaxDemoWeb.Admin.LabelResource},
  #     artist: %{resource: PaxDemoWeb.Admin.ArtistResource},
  #     library: [
  #       label: %{resource: PaxDemoWeb.Admin.LabelResource},
  #       artist: %{resource: PaxDemoWeb.Admin.ArtistResource},
  #       album: %{resource: PaxDemoWeb.Admin.AlbumResource}
  #     ],
  #     library2: %{
  #       title: "Music Library Two",
  #       resources: [
  #         album: %{resource: PaxDemoWeb.Admin.AlbumResource}
  #       ]
  #     }
  #   ]
  # end
end
