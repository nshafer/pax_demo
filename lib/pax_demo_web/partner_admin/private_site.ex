defmodule PaxDemoWeb.PartnerAdmin.PrivateSite do
  use Pax.Admin.Site, router: PaxDemoWeb.Router

  config title: "Partner Admin"

  resource :labels, PaxDemoWeb.PartnerAdmin.LabelResource
  resource :artists, PaxDemoWeb.PartnerAdmin.ArtistResource
  resource :albums, PaxDemoWeb.PartnerAdmin.AlbumResource
end
