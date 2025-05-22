defmodule PaxDemoWeb.Admin.AuthorResource do
  use Pax.Admin.Resource

  def adapter(_socket), do: Pax.Adapters.EctoSchema

  def config(_socket) do
    [
      adapter: [
        repo: PaxDemo.Repo,
        schema: PaxDemo.Library.Author
      ],
      fields: [
        :id,
        {:name, link: true},
        :birth,
        :death
      ],
      default_scope: [
        order_by: :name
      ]
    ]
  end
end
