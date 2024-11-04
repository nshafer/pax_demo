defmodule PaxDemoWeb.Admin.LanguageResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Language}
  end

  def pax_config(_socket) do
    [
      index_fields: [
        {:name, link: true},
        :short
      ]
    ]
  end
end
