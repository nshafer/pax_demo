defmodule PaxDemoWeb.BookLive do
  use PaxDemoWeb, :live_view
  use Pax.Interface
  import Pax.Interface.Components

  def render(assigns) do
    # dbg(Map.delete(assigns, :pax))
    # dbg(assigns.pax)

    ~H"""
    {pax_interface(assigns)}

    <div class="mt-5">
      Current Time: {@time}
      <button class="pax-button" phx-click="refresh">Refresh</button>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, time: DateTime.utc_now(), idx: 0)}
  end

  # Example of this still being a LiveView. Also good way to test change tracking.
  def handle_event("refresh", _params, socket) do
    # dbg(socket.assigns.__changed__)
    # dbg(socket.assigns.pax.objects)

    socket =
      socket
      |> assign(time: DateTime.utc_now())
      |> Pax.Interface.Context.assign_pax(:plural_name, "Books #{socket.assigns.idx}")
      |> assign(idx: socket.assigns.idx + 1)

    # dbg(socket.assigns.__changed__)

    {:noreply, socket}
  end

  # def pax_adapter(_socket) do
  #   {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Book}
  # end

  # def pax_init(_params, _session, socket) do
  #   if connected?(socket) do
  #     {:cont, socket}
  #   else
  #     {:halt, socket}
  #   end
  # end

  def pax_adapter(_socket), do: Pax.Adapters.EctoSchema

  def pax_plugins(_socket) do
    [
      Pax.Plugins.Breadcrumbs,
      Pax.Plugins.Title,
      Pax.Plugins.Pagination
    ]
  end

  def pax_config(_socket) do
    [
      adapter: [
        repo: PaxDemo.Repo,
        schema: PaxDemo.Library.Book
      ],
      singular_name: "Book",
      plural_name: "Books",
      object_name: fn object, _socket -> object.title end,
      index_path: ~p"/books",
      new_path: ~p"/books/new",
      show_path: fn object, _socket -> ~p"/books/#{object.id}/#{object.slug}" end,
      edit_path: fn object, _socket -> ~p"/books/#{object.id}/#{object.slug}/edit" end,
      lookup_params: ["id", "slug"],
      id_fields: [:id, :slug],
      index_fields: [
        {:title, link: true, truncate: 30},
        :rank,
        :downloads,
        :reading_level,
        :publication_date
      ],
      fieldsets: [
        default: [
          [:title, :slug],
          [:author_id, :language_id],
          :visible
        ],
        metadata: [
          :pg_id,
          :publication_date,
          [{:inserted_at, immutable: true}, {:updated_at, immutable: true}]
        ],
        statistics: [
          [:rank, :downloads],
          [:reading_level, :words]
        ]
      ],
      plugins: [
        pagination: [
          objects_per_page: 15
        ]
      ]
    ]
  end
end
