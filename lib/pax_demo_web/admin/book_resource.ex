defmodule PaxDemoWeb.Admin.BookResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Book, id_field: :slug}
  end

  def config(_socket) do
    [
      object_name: fn object, _socket -> object.title end,
      id_fields: [:id, :slug],
      index_fields: [
        :id,
        {:title, link: true},
        :rank,
        :downloads,
        :reading_level,
        :words,
        :publication_date
      ],
      fieldsets: [
        default: [
          [:title, :slug],
          :visible,
          :author_id,
          :language_id
        ],
        metadata: [
          :pg_id,
          :publication_date,
          :inserted_at,
          :updated_at
        ],
        statistics: [
          [:rank, :downloads],
          [:reading_level, :words]
        ]
      ]
    ]
  end
end
