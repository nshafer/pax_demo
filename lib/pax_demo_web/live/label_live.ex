defmodule PaxDemoWeb.LabelLive do
  use PaxDemoWeb, :live_view
  use Pax.Interface
  import Pax.Interface.Components

  @impl true
  def render(assigns) do
    # dbg(assigns.pax)

    # if assigns[:object] do
    #   IO.puts("Object: #{inspect(assigns[:object])}")
    # end

    # if assigns[:objects] do
    #   IO.puts("Num objects: #{length(assigns[:objects])}")
    # end

    ~H"""
    <%= if assigns[:pax] do %>
      <.pax_index :if={@live_action == :index} pax={@pax} />
      <.pax_show :if={@live_action == :show} pax={@pax} />
      <.pax_new :if={@live_action == :new} pax={@pax} />
      <.pax_edit :if={@live_action == :edit} pax={@pax} />
    <% else %>
      Loading...
    <% end %>

    <div>
      Time: <%= @time %>
      <.button phx-click="tick">Tick</.button>
    </div>
    """
  end

  # EXAMPLE: don't perform full pax init on initial non-live hit
  # @impl true
  # def pax_init(_params, _session, socket) do
  #   if connected?(socket) do
  #     {:cont, socket}
  #   else
  #     {:halt, socket}
  #   end
  # end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :time, DateTime.utc_now())}
  end

  @impl true
  def handle_event("tick", _params, socket) do
    {:noreply, assign(socket, :time, DateTime.utc_now())}
  end

  @impl true
  def adapter(_socket), do: {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Label}

  @impl true
  def plugins(_socket) do
    [
      Pax.Plugins.Pagination
      # {Pax.Plugins.Pagination, objects_per_page: 5}
    ]
  end

  @impl true
  def pax_config(_socket) do
    [
      singular_name: "Label",
      plural_name: "Labels",
      index_path: ~p"/labels",
      new_path: ~p"/labels/new",
      show_path: fn object, _socket -> ~p"/labels/#{object}" end,
      edit_path: fn object, _socket -> ~p"/labels/#{object}/edit" end,
      object_name: fn object, _socket -> object.name end,
      # objects_per_page: 4,
      objects_per_page: fn _socket -> 7 end,
      index_fields: [
        :id,
        # :name,
        {:name, link: true},
        :founded,
        {:rating, :string, value: &format_rating/1},
        :accepting_submissions
      ],
      fieldsets: [
        default: [
          [
            :name,
            :slug
          ],
          [
            :founded,
            {:rating, :float, title: "Rating (0-5)", round: 2, required: false}
          ],
          {:accepting_submissions, :boolean, true: "Yes", false: "No"}
        ],
        metadata: [
          [
            {:id, immutable: true},
            {:inserted_at, :datetime, immutable: true},
            {:updated_at, :datetime, immutable: true}
          ]
        ]
      ]
    ]
  end

  def format_rating(%{rating: nil}), do: "-"
  def format_rating(%{rating: rating}), do: rating |> Float.round(2) |> Float.to_string()
end
