defmodule PaxDemoWeb.PartnerAdmin.PublicSite do
  use Pax.Admin.Site, router: PaxDemoWeb.Router

  config title: "Public Admin"

  resource :labels, PaxDemoWeb.PartnerAdmin.LabelResource
  resource :artists, PaxDemoWeb.PartnerAdmin.ArtistResource
  resource :albums, PaxDemoWeb.PartnerAdmin.AlbumResource
end
