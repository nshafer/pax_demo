defmodule PaxDemoWeb.PartnerAdmin.LabelResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Label}
  end

  def index_fields(_socket) do
    [{:name, link: true}, :rating, :accepting_submissions]
  end

  def fieldsets(_socket) do
    [
      {:name, :string},
      {:rating, :float, title: "Rating (0-5)", round: 2},
      {:accepting_submissions, :boolean, true: "Yes", false: "No"}
    ]
  end
end
