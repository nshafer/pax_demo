defmodule PaxDemoWeb.LabelLive.Detail do
  use PaxDemoWeb, :live_view
  use Pax.Detail.Live

  def render(assigns) do
    # IO.inspect(assigns, label: "assigns")

    ~H"""
    <h1 class="text-2xl pb-2 border-b mb-5">
      <.link navigate={~p"/labels"}>⬅</.link>
      <%= @object.name %>
    </h1>
    <Pax.Detail.Components.detail class="" fieldsets={@fieldsets} object={@object} />
    """
  end

  def adapter(_params, _session, _socket) do
    {Pax.SchemaAdapter, repo: PaxDemo.Repo, schema: PaxDemo.Library.Label}
  end

  def lookup(query, %{"id" => id}, _uri, _socket) do
    import Ecto.Query
    from q in query, where: q.id == ^id
  end

  # def fields(_params, _session, _socket) do
  #   [
  #     [
  #       {:id, :integer},
  #       {:name, :string}
  #     ],
  #     {:rating, :float, title: "Rating (0-5)", round: 2},
  #     {:accepting_submissions, :boolean, true: "Yes", false: "No"},
  #     {:inserted_at, :datetime},
  #     {:updated_at, :datetime}
  #   ]
  # end

  def fieldsets(_params, _session, _socket) do
    [
      default: [
        # {:name, :string},
        [
          {:name, :string},
          {:slug, :string}
        ],
        # [
        #   {:name, :string},
        #   {:slug, :string},
        #   {:founded, :integer, title: "Founded (YYYY)"}
        # ],
        # [
        #   {:name, :string},
        #   {:slug, :string},
        #   {:founded, :integer, title: "Founded (YYYY)"},
        #   {:rating, :float, title: "Rating (0-5)", round: 2}
        # ],
        # [
        #   {:rating, :float, title: "Rating (0-5)", round: 2},
        #   {:accepting_submissions, :boolean, true: "Yes", false: "No"}
        # ],
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
