defmodule PaxDemoWeb.PartnerAdmin.ArtistResource do
  use Pax.Admin.Resource

  def pax_adapter(_params, _session, _socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Artist}
  end

  def pax_index_fields(_params, _session, _socket) do
    [{:name, link: true}, :rating, :started, :ended]
  end

  def pax_detail_fieldsets(_params, _session, _socket) do
    [
      [:name, :slug],
      :rating,
      [:started, :ended]
    ]
  end
end
