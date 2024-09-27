defmodule PaxDemoWeb.MainAdmin.ArtistResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Artist}
  end

  # This purposefully left at the absolute minimum amount of config to show default
  # configuration derived from the adapter
end
