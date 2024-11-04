defmodule PaxDemoWeb.Admin.BookResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Book}
  end

  def pax_config(_socket) do
    [
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
