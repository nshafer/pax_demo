# Loads the included classics.json file and populates the database with its contents

alias PaxDemo.Classics

# Set the logger to :info level so we don't get Ecto debug log messages of every query
Logger.configure(level: :info)

# Load the JSON file and process each book, maintaining a cache of already inserted associated data
for book_json <- Classics.read_json(), reduce: {%{}, %{}, %{}, %{}} do
  {language_cache, author_cache, subject_cache, classification_cache} ->
    IO.puts("Processing #{book_json["bibliography"]["title"]}")

    # Get or create the Language for this book
    {language, language_cache} = Classics.get_or_create_language(book_json["bibliography"]["languages"], language_cache)
    IO.puts("  Language [#{language.id}]: #{language.name} (#{language.short})")

    # Get or create the Author for this book
    {author, author_cache} = Classics.get_or_create_author(book_json["bibliography"]["author"], author_cache)
    IO.puts("  Author [#{author.id}]: #{author.name} (#{author.birth} - #{author.death})")

    # Create the Book
    book = Classics.create_book(book_json, language, author)
    IO.puts("  Book [#{book.id}]: #{book.title}")

    # Get or create the Subjects for this book
    {subjects, subject_cache} = Classics.get_or_create_subjects(book_json["bibliography"]["subjects"], subject_cache)

    # Create BookSubjects for this book, preserving the order from the JSON
    for {subject, order} <- Enum.with_index(subjects, 1) do
      IO.puts("  Subject [#{subject.id}]: #{subject.name}")
      Classics.create_book_subject(book, subject, order * 10)
    end

    # Get or create the Classifications for this book
    {classifications, classification_cache} =
      Classics.get_or_create_classifications(
        book_json["bibliography"]["congress classifications"],
        classification_cache
      )

    # Insert books_classifications rows for this book
    for classification <- classifications do
      IO.puts("  Classification [#{classification.id}]: #{classification.name} (#{classification.short})")
      Classics.create_book_classification(book, classification)
    end

    {language_cache, author_cache, subject_cache, classification_cache}
end
