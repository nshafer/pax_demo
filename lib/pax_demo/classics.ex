defmodule PaxDemo.Classics do
  @moduledoc false

  # This module provides functionality for loading the library database from classics.json in the repo/seeds.exs script
  # Data is from: https://corgis-edu.github.io/corgis/json/classics/

  alias PaxDemo.Repo
  alias PaxDemo.Library.Book
  alias PaxDemo.Library.Author
  alias PaxDemo.Library.Language
  alias PaxDemo.Library.Subject
  alias PaxDemo.Library.BookSubject
  alias PaxDemo.Library.Classification

  # https://www.loc.gov/standards/iso639-2/php/English_list.php
  @languages %{
    "en" => "English",
    "fr" => "French",
    "de" => "German",
    "it" => "Italian",
    "es" => "Spanish",
    "enm" => "Middle English",
    "la" => "Latin",
    "nl" => "Dutch",
    "pt" => "Portuguese",
    "ru" => "Russian",
    "tl" => "Tagalog"
  }

  # https://www.loc.gov/catdir/cpso/lcco/
  @classifications %{
    "AG" => "Dictionaries and Other General Reference Works",
    "AZ" => "History of Scholarship and Learning. The Humanities",
    "B" => "Philosophy (General)",
    "BC" => "Logic",
    "BF" => "Psychology",
    "BJ" => "Ethics",
    "BL" => "Religions. Mythology. Rationalism",
    "BP" => "Islam. Bahaism. Theosophy, etc.",
    "BQ" => "Buddhism",
    "BR" => "Christianity",
    "BS" => "The Bible",
    "BT" => "Doctrinal Theology",
    "BX" => "Christian Denominations",
    "BV" => "Practical Theology",
    "CR" => "Heraldry",
    "CS" => "Genealogy",
    "CT" => "Biography",
    "D" => "History (General)",
    "DA" => "Great Britain",
    "DC" => "France - Andorra - Monaco",
    "DE" => "Greco-Roman World",
    "DF" => "Greece",
    "DG" => "Italy - Malta",
    "DS" => "Asia",
    "D501" => "World War I",
    "E011" => "United States History",
    "E151" => "United States History",
    "E201" => "United States History",
    "E300" => "American History",
    "E456" => "United States History",
    "E660" => "United States History",
    "F001" => "United States History",
    "F1201" => "Latin America",
    "F1401" => "Latin America",
    "F2155" => "Latin America",
    "F2301" => "Latin America",
    "F590.3" => "United States History",
    "G" => "Geography. Anthropology. Recreation",
    "GN" => "Anthropology",
    "GR" => "Folklore",
    "GT" => "Manners and Customs (General)",
    "HB" => "Economic Theory. Demography",
    "HC" => "Economic History and Conditions",
    "HD" => "Industries. Land use. Labor",
    "HF" => "Commerce",
    "HM" => "Sociology (General)",
    "HN" => "Social History and Conditions. Social Problems. Social Reform",
    "HQ" => "The Family. Marriage. Women",
    "HS" => "Societies: secret, benevolent, etc.",
    "HT" => "Communities. Classes. Races",
    "HV" => "Social Pathology. Social and Public Welfare. Criminology",
    "HX" => "Socialism. Communism. Anarchism",
    "JC" => "Political Theory",
    "JK" => "Political Institutions and Public Administration (United States)",
    "JN" => "Political Institutions and Public Administration (Europe)",
    "K" => "Law in General. Comparative and Uniform Law. Jurisprudence",
    "KF" => "Law of the United States",
    "LB" => "Theory and Practice of Education",
    "M" => "Music",
    "ML" => "Literature on Music",
    "N" => "Visual Arts (General)",
    "NA" => "Architecture",
    "NC" => "Drawing. Design. Illustration",
    "NK" => "Decorative Arts",
    "ND" => "Painting",
    "PA" => "Classical Philology and Literature",
    "PB" => "Modern Languages. Celtic Languages",
    "PC" => "Romance Philology and Literature",
    "PE" => "English Language",
    "PG" => "Slavic, Baltic, and Albanian Literature",
    "PJ" => "Oriental Philology and Literature",
    "PK" => "Indo-Iranian Philology and Literature",
    "PL" => "Languages and Literatures of Eastern Asia, Africa, Oceania",
    "PN" => "Literature (General)",
    "PQ" => "French Literature",
    "PR" => "English Literature",
    "PS" => "American Literature",
    "PT" => "German Literature",
    "PZ" => "Children's Literature",
    "Q" => "Science (General)",
    "QA" => "Mathematics",
    "QC" => "Physics",
    "QH" => "Natural History - Biology",
    "SK" => "Hunting. Fishing. Conservation",
    "T" => "Technology (General)",
    "TA" => "Engineering (General). Civil Engineering",
    "TJ" => "Mechanical Engineering and Machinery",
    "TL" => "Motor Vehicles. Aeronautics. Astronautics",
    "TR" => "Photography",
    "TT" => "Handicrafts. Arts and Crafts",
    "TX" => "Home Economics",
    "U" => "Military Science (General)",
    "UH" => "Other Military Services",
    "VM" => "Naval Science",
    "Z" => "Books (General). Writing. Paleography. Book Industries and Trade. Libraries. Bibliography"
  }

  def read_json() do
    Path.join([Application.app_dir(:pax_demo, "priv"), "repo", "classics.json"])
    |> File.read!()
    |> Jason.decode!()
  end

  def create_book(%{} = book, %Language{} = language, %Author{} = author) do
    %Book{
      title: book["bibliography"]["title"],
      slug: slugify(book["bibliography"]["title"]),
      publication_date:
        Date.new!(
          book["bibliography"]["publication"]["year"],
          book["bibliography"]["publication"]["month"],
          book["bibliography"]["publication"]["day"]
        ),
      pg_id: book["metadata"]["id"],
      rank: book["metadata"]["rank"],
      downloads: book["metadata"]["downloads"],
      words: book["metrics"]["statistics"]["words"],
      reading_level: book["metrics"]["difficulty"]["flesch kincaid grade"],
      language_id: language.id,
      author_id: author.id
    }
    |> Repo.insert!()
  end

  def get_or_create_language(language, language_cache) do
    # If language is a list, only get the first language
    language = language |> String.split(",") |> Enum.map(&String.trim/1) |> hd()

    case Map.get(language_cache, language) do
      nil ->
        language = %Language{
          short: language,
          name: Map.get(@languages, language)
        }

        language = Repo.insert!(language, returning: true)
        {language, Map.put(language_cache, language.short, language)}

      language ->
        {language, language_cache}
    end
  end

  def get_or_create_author(author, author_cache) do
    case Map.get(author_cache, author["name"]) do
      nil ->
        author = %Author{
          name: author["name"],
          birth: if(author["birth"] == 0, do: nil, else: author["birth"]),
          death: if(author["death"] == 0, do: nil, else: author["death"])
        }

        author = Repo.insert!(author, returning: true)
        {author, Map.put(author_cache, author.name, author)}

      author ->
        {author, author_cache}
    end
  end

  def get_or_create_subjects(subjects_str, subject_cache) do
    subjects_list = parse_subjects(subjects_str)

    {subjects, subject_cache} =
      for subject_str <- subjects_list, reduce: {[], subject_cache} do
        {subjects, subject_cache} ->
          case Map.get(subject_cache, subject_str) do
            nil ->
              subject = %Subject{
                name: subject_str
              }

              subject = Repo.insert!(subject, returning: true)
              {[subject | subjects], Map.put(subject_cache, subject.name, subject)}

            subject ->
              {[subject | subjects], subject_cache}
          end
      end

    {Enum.reverse(subjects), subject_cache}
  end

  def create_book_subject(book, subject, order) do
    Repo.insert!(%BookSubject{book_id: book.id, subject_id: subject.id, order: order})
  end

  def get_or_create_classifications(classifications_str, classifications_cache) do
    classifications_list = parse_classifications(classifications_str)

    {classifications, classifications_cache} =
      for classification_str <- classifications_list, reduce: {[], classifications_cache} do
        {classifications, classifications_cache} ->
          case Map.get(classifications_cache, classification_str) do
            nil ->
              classification = %Classification{
                short: classification_str,
                name: Map.fetch!(@classifications, classification_str)
              }

              classification = Repo.insert!(classification, returning: true)
              {[classification | classifications], Map.put(classifications_cache, classification.short, classification)}

            classification ->
              {[classification | classifications], classifications_cache}
          end
      end

    {Enum.reverse(classifications), classifications_cache}
  end

  def create_book_classification(book, classification) do
    Repo.insert_all("books_classifications", [%{book_id: book.id, classification_id: classification.id}])
  end

  def slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "-")
    |> String.replace(~r/-+/, "-")
    |> String.replace(~r/^-/, "")
    |> String.replace(~r/-$/, "")
    |> String.slice(0, 255)
  end

  defp parse_subjects(subjects_str) do
    cond do
      String.contains?(subjects_str, ";") -> split_subjects_by_semicolon(subjects_str)
      String.contains?(subjects_str, ",") -> split_subjects_by_comma(subjects_str)
      true -> [subjects_str]
    end
  end

  defp split_subjects_by_semicolon(subjects_str) do
    subjects_str
    |> String.split(";", trim: true)
    |> Enum.map(&String.trim/1)
  end

  defp split_subjects_by_comma(subjects_str) do
    # Replace any occurrence of a comma with a non-whitespace character on either side with a semicolon, then split
    # by semicolon. This is because the dataset sometimes uses a comma without spaces to separate multiple subjects
    # e.g. "History,Heroes" -> ["History", "Heroes"]
    # but  "History,History, English" -> ["History", "History, English"] as two subjects
    subjects_str
    |> String.replace(~r/(\S),(\S)/, "\\1;\\2")
    |> split_subjects_by_semicolon()
  end

  defp parse_classifications(classifications_str) do
    classifications_str
    |> String.split(",", trim: true)
    |> Enum.map(&String.trim/1)
  end
end
