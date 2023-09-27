defmodule PaxDemoWeb.PartnerAdmin.LabelResource do
  use Pax.Admin.Resource

  def pax_adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Label}
  end

  def pax_index_fields(_socket) do
    [{:name, link: true}, :rating, :accepting_submissions]
  end

  def pax_detail_fieldsets(_socket) do
    [
      {:name, :string},
      {:rating, :float, title: "Rating (0-5)", round: 2},
      {:accepting_submissions, :boolean, true: "Yes", false: "No"}
    ]
  end
end
