defmodule PaxDemo.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :title, :string
    field :slug, :string
    field :visible, :boolean, default: true
    field :publication_date, :date
    field :pg_id, :integer
    field :rank, :integer
    field :downloads, :integer
    field :words, :integer
    field :reading_level, :float

    belongs_to :author, PaxDemo.Library.Author
    belongs_to :language, PaxDemo.Library.Language

    has_many :book_subjects, PaxDemo.Library.BookSubject

    many_to_many :classifications, PaxDemo.Library.Classification, join_through: "books_classifications"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [
      :title,
      :slug,
      :visible,
      :pg_id,
      :rank,
      :publication_date,
      :downloads,
      :words,
      :reading_level,
      :author_id,
      :language_id
    ])
    |> validate_required([:title, :slug, :author_id, :language_id])
    |> validate_length(:title, max: 255)
    |> validate_length(:slug, max: 255)
    |> validate_number(:pg_id, greater_than: 0)
    |> validate_number(:rank, greater_than: 0)
    |> validate_number(:downloads, greater_than: 0)
    |> validate_number(:words, greater_than: 0)
    |> validate_number(:reading_level, greater_than: 0)
  end
end
