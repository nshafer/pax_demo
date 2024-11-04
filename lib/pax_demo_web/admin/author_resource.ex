defmodule PaxDemoWeb.Admin.AuthorResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Author}
  end

  def pax_config(_socket) do
    [
      index_fields: [
        :id,
        {:name, link: true},
        :birth,
        :death
      ]
    ]
  end
end
