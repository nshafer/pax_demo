defmodule PaxDemoWeb.BookLive do
  use PaxDemoWeb, :live_view
  use Pax.Interface
  import Pax.Interface.Components

  def render(assigns) do
    # dbg(assigns.pax)

    ~H"""
    <%= if assigns[:pax] do %>
      <.pax_index :if={@live_action == :index} pax={@pax} />
      <.pax_show :if={@live_action == :show} pax={@pax} />
      <.pax_new :if={@live_action == :new} pax={@pax} />
      <.pax_edit :if={@live_action == :edit} pax={@pax} />
    <% else %>
      Loading...
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
      repo: PaxDemo.Repo,
      schema: PaxDemo.Library.Book,
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
        {:title, link: true},
        :rank,
        :downloads,
        :reading_level,
        :publication_date
      ],
      fieldsets: [
        default: [
          [:title, :slug],
          [:rank, :downloads],
          [:reading_level, :words],
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
      ]
    ]
  end
end
