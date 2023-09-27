defmodule PaxDemoWeb.LabelLive.Detail do
  use PaxDemoWeb, :live_view
  use Pax.Detail.Live

  def render(assigns) do
    # dbg(assigns)

    ~H"""
    <Pax.Detail.Components.show :if={@live_action == :show} pax={@pax} object={@object} />
    <Pax.Detail.Components.edit :if={@live_action in [:edit, :new]} pax={@pax} object={@object} form={@form} />
    """
  end

  def pax_adapter(_params, _session, _socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Label}
  end

  def pax_index_path(_socket), do: ~p"/labels/"
  def pax_show_path(_socket, object), do: ~p"/labels/#{object.id}"
  def pax_edit_path(_socket, object), do: ~p"/labels/#{object.id}/edit"
  def pax_object_name(_socket, object), do: object.name

  # def pax_lookup(query, %{"id" => id}, _uri, _socket) do
  #   import Ecto.Query
  #   from q in query, where: q.id == ^id
  # end

  # def pax_fieldsets(_params, _session, _socket) do
  #   [:id, :name, :rating, :accepting_submissions, :inserted_at, :updated_at]
  # end

  def pax_fieldsets(_params, _session, _socket) do
    [
      [
        :name,
        :slug
      ],
      [
        :founded,
        {:rating, :float, title: "Rating (0-5)", round: 2, required: false}
      ],
      {:accepting_submissions, :boolean, true: "Yes", false: "No"},
      {:inserted_at, :datetime, immutable: true},
      {:updated_at, :datetime, immutable: true}
    ]
  end

  # def pax_fieldsets(_params, _session, _socket) do
  #   [
  #     default: [
  #       # {:name, :string},
  #       [
  #         {:name, :string},
  #         {:slug, :string}
  #       ],
  #       # [
  #       #   {:name, :string},
  #       #   {:slug, :string},
  #       #   {:founded, :integer, title: "Founded (YYYY)"}
  #       # ],
  #       # [
  #       #   {:name, :string},
  #       #   {:slug, :string},
  #       #   {:founded, :integer, title: "Founded (YYYY)"},
  #       #   {:rating, :float, title: "Rating (0-5)", round: 2}
  #       # ],
  #       # [
  #       #   {:rating, :float, title: "Rating (0-5)", round: 2},
  #       #   {:accepting_submissions, :boolean, true: "Yes", false: "No"}
  #       # ],
  #       {:rating, :float, title: "Rating (0-5)", round: 2},
  #       {:accepting_submissions, :boolean, true: "Yes", false: "No"}
  #     ],
  #     meta: [
  #       {:id, :integer, title: "ID"},
  #       {:inserted_at, :datetime},
  #       {:updated_at, :datetime}
  #     ]
  #   ]
  # end
end
