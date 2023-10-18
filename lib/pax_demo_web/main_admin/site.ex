defmodule PaxDemoWeb.MainAdmin.Site do
  use Pax.Admin.Site, router: PaxDemoWeb.Router
  # use Phoenix.Component

  # def render_index(assigns) do
  #   ~H"""
  #   <h1 class="text-2xl mb-3 flex justify-between">Labels <small>PaxDemoWeb.Admin</small></h1>
  #   <Pax.Index.Components.index pax_fields={@pax_fields} objects={@objects} />
  #   """
  # end

  config title: "Main Admin"

  resource :labels, PaxDemoWeb.MainAdmin.LabelResource, sort: :name
  resource :artists, PaxDemoWeb.MainAdmin.ArtistResource
  resource :albums, PaxDemoWeb.MainAdmin.AlbumResource

  # link "More info", "https://somewhere.com/asdf"

  section :library do
    resource :labels, PaxDemoWeb.MainAdmin.LabelResource
    resource :artists, PaxDemoWeb.MainAdmin.ArtistResource
    resource :albums, PaxDemoWeb.MainAdmin.AlbumResource
    resource :albums2, PaxDemoWeb.MainAdmin.AlbumResource, label: "Second Albums"
    # page :info, "Information", PaxDemoWeb.Admin.InfoPage
  end

  resource :labels2, PaxDemoWeb.MainAdmin.LabelResource
  resource :artists2, PaxDemoWeb.MainAdmin.ArtistResource
  resource :albums2, PaxDemoWeb.MainAdmin.AlbumResource

  section :library2, label: "Music Library Two" do
    resource :albums_two, PaxDemoWeb.MainAdmin.AlbumResource
  end

  # def config(_params, _session, _socket) do
  #   %{
  #     title: "Pax Demo Admin at Runtime"
  #   }
  # end

  # def resources(_params, _session, _socket) do
  #   [
  #     label: %{title: "Labels", resource: PaxDemoWeb.MainAdmin.LabelResource},
  #     artist: %{resource: PaxDemoWeb.MainAdmin.ArtistResource, some_opt: "asdf"},
  #     music_library: [
  #       label: %{resource: PaxDemoWeb.MainAdmin.LabelResource},
  #       artist: %{resource: PaxDemoWeb.MainAdmin.ArtistResource},
  #       album: %{resource: PaxDemoWeb.MainAdmin.AlbumResource}
  #     ],
  #     library2: %{
  #       title: "Music Library Two",
  #       resources: [
  #         album: %{resource: PaxDemoWeb.MainAdmin.AlbumResource}
  #       ]
  #     }
  #   ]
  # end
end
