defmodule PaxDemoWeb.MainAdmin.LabelResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Label}
  end

  # def index_fields(_params, _session, _socket) do
  #   []
  # end

  def index_fields(_socket) do
    [:id, {:name, link: true}, :rating, :accepting_submissions, :inserted_at, :updated_at]
  end

  # def fieldsets(_params, _session, _socket) do
  #   [
  #     :id,
  #     :name,
  #     :rating,
  #     :accepting_submissions,
  #     :inserted_at,
  #     :updated_at
  #   ]
  # end

  def fieldsets(_socket) do
    [
      default: [
        [
          {:name, :string},
          {:slug, :string}
        ],
        {:rating, :float, label: "Rating (0-5)", round: 2},
        {:accepting_submissions, :boolean, true: "Yes", false: "No"}
      ],
      meta: [
        {:id, :integer, label: "ID#", immutable: true},
        {:inserted_at, :datetime, immutable: true},
        {:updated_at, :datetime, immutable: true}
      ]
    ]
  end
end
