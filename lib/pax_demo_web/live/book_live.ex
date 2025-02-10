defmodule PaxDemoWeb.BookLive do
  use PaxDemoWeb, :live_view
  use Pax.Interface
  import Pax.Interface.Components

  def render(assigns) do
    # dbg(assigns.pax)
    # dbg(assigns.pax.config)

    ~H"""
    <%= if assigns[:pax] do %>
      <.pax_interface pax={@pax} action={@live_action} />
    <% end %>
    """
  end

  # def pax_adapter(_socket) do
  #   {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Book}
  # end

  def pax_adapter(_socket), do: Pax.Adapters.EctoSchema

  def pax_plugins(_socket) do
    [
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
          [:inserted_at, :updated_at]
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
