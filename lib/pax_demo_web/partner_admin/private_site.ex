defmodule PaxDemoWeb.PartnerAdmin.PrivateSite do
  use Pax.Admin.Site, router: PaxDemoWeb.Router

  config title: "Partner Admin"

  resource :label, "Labels", PaxDemoWeb.PartnerAdmin.LabelResource
  resource :artist, "Artists", PaxDemoWeb.PartnerAdmin.ArtistResource
  resource :album, "Albums", PaxDemoWeb.PartnerAdmin.AlbumResource
end
