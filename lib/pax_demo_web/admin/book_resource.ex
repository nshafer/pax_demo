defmodule PaxDemoWeb.Admin.BookResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Book, id_field: :slug}
  end

  def plugins(_socket) do
    [
      Pax.Plugins.Title,
      {Pax.Plugins.Pagination, objects_per_page: 100},
      Pax.Plugins.IndexTable,
      Pax.Plugins.DetailFieldsets,
      Pax.Plugins.NewButton
    ]
  end

  def config(_socket) do
    [
      object_name: fn object, _socket -> object.title end,
      id_fields: [:id, :slug],
      fields: [
        :id,
        {:title, link: true, truncate: 50},
        :rank,
        :downloads,
        {:reading_level, round: 1},
        :words,
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
        order_by: :title
      ],
      plugins: [
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
