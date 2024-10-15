defmodule PaxDemo.Library.BookSubject do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books_subjects" do
    belongs_to :book, PaxDemo.Library.Book
    belongs_to :subject, PaxDemo.Library.Subject
    field :order, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book_subject, attrs) do
    book_subject
    |> cast(attrs, [:book_id, :subject_id, :order])
    |> validate_required([:book_id, :subject_id, :order])
    |> validate_number(:order, greater_than: 0)
  end
end
