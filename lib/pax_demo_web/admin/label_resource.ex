defmodule PaxDemoWeb.Admin.LabelResource do
  use PaxDemoWeb, :pax_resource

  # def render_index(assigns) do
  #   ~H"""
  #   <h1 class="text-2xl mb-3 flex justify-between">Labels <small>PaxDemoWeb.Admin.Label</small></h1>
  #   <Pax.Index.Components.index pax_fields={@pax_fields} objects={@objects} />
  #   """
  # end

  def pax_adapter(_params, _session, _socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Label}
  end

  # def pax_index_fields(_params, _session, _socket) do
  #   []
  # end

  def pax_index_fields(_params, _session, _socket) do
    [:id, {:name, link: true}, :rating, :accepting_submissions, :inserted_at, :updated_at]
  end

  # def pax_detail_fieldsets(_params, _session, _socket) do
  #   [
  #     :id,
  #     :name,
  #     :rating,
  #     :accepting_submissions,
  #     :inserted_at,
  #     :updated_at
  #   ]
  # end

  def pax_detail_fieldsets(_params, _session, _socket) do
    [
      default: [
        [
          {:name, :string},
          {:slug, :string}
        ],
        {:rating, :float, title: "Rating (0-5)", round: 2},
        {:accepting_submissions, :boolean, true: "Yes", false: "No"}
      ],
      meta: [
        {:id, :integer, title: "ID"},
        {:inserted_at, :datetime},
        {:updated_at, :datetime}
      ]
    ]
  end
end
