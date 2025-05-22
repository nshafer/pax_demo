defmodule PaxDemoWeb.Admin.SubjectResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Subject}
  end

  def config(_socket) do
    [
      fields: [
        {:name, link: true}
      ]
    ]
  end
end
