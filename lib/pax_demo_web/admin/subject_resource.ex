defmodule PaxDemoWeb.Admin.SubjectResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Subject}
  end

  def pax_config(_socket) do
    [
      index_fields: [
        {:name, link: true}
      ]
    ]
  end
end
