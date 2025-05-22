defmodule PaxDemoWeb.Admin.ClassificationResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Classification}
  end

  def config(_socket) do
    [
      fields: [
        {:name, link: true},
        :short
      ]
    ]
  end
end
