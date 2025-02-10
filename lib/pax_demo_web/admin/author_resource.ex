defmodule PaxDemoWeb.Admin.AuthorResource do
  use Pax.Admin.Resource

  def adapter(_socket), do: Pax.Adapters.EctoSchema

  def config(_socket) do
    [
      adapter: [
        repo: PaxDemo.Repo,
        schema: PaxDemo.Library.Author
      ],
      index_fields: [
        :id,
        {:name, link: true},
        :birth,
        :death
      ]
    ]
  end
end
