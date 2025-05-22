defmodule PaxDemoWeb.BookLive do
  use PaxDemoWeb, :live_view
  use Pax.Interface

  def render(assigns) do
    ~H"""
    {Pax.Interface.Components.pax_interface(assigns)}
    """
  end

  def pax_adapter(_socket), do: Pax.Adapters.EctoSchema

  def pax_plugins(_socket) do
    [
      Pax.Plugins.Breadcrumbs,
      Pax.Plugins.Title,
      Pax.Plugins.Pagination,
      Pax.Plugins.IndexTable,
      Pax.Plugins.DetailFieldsets
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
      fields: [
        {:title, link: true, truncate: 30},
        :rank,
        :downloads,
        :reading_level,
        :publication_date,
        {:slug, except: :index},
        {:author_id, except: :index},
        {:language_id, except: :index},
        {:visible, except: :index},
        {:pg_id, except: :index},
        {:inserted_at, immutable: true, except: :index},
        {:updated_at, immutable: true, except: :index},
        {:words, except: :index}
      ],
      default_scope: [
        order_by: [asc: :rank]
      ],
      plugins: [
        pagination: [
          objects_per_page: 15
        ],
        detail_fieldsets: [
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
          ]
        ]
      ]
    ]
  end
end
