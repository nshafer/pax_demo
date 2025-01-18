defmodule PaxDemo.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :string, null: false
      add :birth, :integer
      add :death, :integer

      timestamps(type: :utc_datetime)
    end

    create unique_index(:authors, [:name])

    create table(:languages) do
      add :name, :string, null: false
      add :short, :string, size: 3, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:languages, [:name])
    create unique_index(:languages, [:short])

    create table(:subjects) do
      add :name, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:subjects, [:name])

    create table(:classifications) do
      add :name, :string, null: false
      add :short, :string, size: 10, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:classifications, [:name, :short])

    create table(:books) do
      add :title, :text, null: false
      add :slug, :string, null: false
      add :visible, :boolean, default: true
      add :pg_id, :integer
      add :rank, :integer
      add :publication_date, :date
      add :downloads, :integer
      add :words, :integer
      add :reading_level, :float

      add :author_id, references(:authors, on_delete: :delete_all)
      add :language_id, references(:languages, on_delete: :restrict)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:books, [:slug])

    create table(:books_subjects) do
      add :book_id, references(:books, on_delete: :delete_all)
      add :subject_id, references(:subjects, on_delete: :delete_all)
      add :order, :integer, null: false

      timestamps(type: :utc_datetime)
    end

    create table(:books_classifications, primary_key: false) do
      add :book_id, references(:books, on_delete: :delete_all)
      add :classification_id, references(:classifications, on_delete: :delete_all)
    end
  end
end
