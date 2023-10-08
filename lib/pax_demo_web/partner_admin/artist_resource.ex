defmodule PaxDemoWeb.PartnerAdmin.ArtistResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Artist}
  end

  def index_fields(_socket) do
    [{:name, link: true}, :rating, :started, :ended]
  end

  def fieldsets(_socket) do
    [
      [:name, :slug],
      :rating,
      [:started, :ended]
    ]
  end
end
