defmodule PaxDemo.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias PaxDemo.Repo

  # Book
  alias PaxDemo.Library.Book

  def list_books do
    Repo.all(Book)
    |> Repo.preload([:author, :language, :classifications, book_subjects: [:book, :subject]])
  end

  def get_book!(id) do
    Repo.get!(Book, id)
    |> Repo.preload([:author, :language, :classifications, book_subjects: [:book, :subject]])
  end

  # Author
  alias PaxDemo.Library.Author

  def list_authors do
    Repo.all(Author)
  end

  def get_author!(id), do: Repo.get!(Author, id)

  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  def delete_author(%Author{} = author) do
    Repo.delete(author)
  end

  def change_author(%Author{} = author, attrs \\ %{}) do
    Author.changeset(author, attrs)
  end
end
