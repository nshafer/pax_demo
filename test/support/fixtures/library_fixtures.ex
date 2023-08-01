defmodule PaxDemo.LibraryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PaxDemo.Library` context.
  """

  @doc """
  Generate a label.
  """
  def label_fixture(attrs \\ %{}) do
    {:ok, label} =
      attrs
      |> Enum.into(%{
        name: "some label",
        rating: 2.5,
        founded: 1979,
        accepting_submissions: true
      })
      |> PaxDemo.Library.create_label()

    label
  end

  @doc """
  Generate a artist.
  """
  def artist_fixture(attrs \\ %{}) do
    label = label_fixture(%{name: "some artist's label"})

    {:ok, artist} =
      attrs
      |> Enum.into(%{
        name: "some artist",
        started: ~N[2023-07-30 23:55:00],
        rating: 3.4,
        ended: ~N[2023-07-30 23:55:00],
        current_label_id: label.id
      })
      |> PaxDemo.Library.create_artist()

    artist
  end

  @doc """
  Generate a album.
  """
  def album_fixture(attrs \\ %{}) do
    label = label_fixture(%{name: "some album's label"})
    artist = artist_fixture(%{name: "some album's artist"})

    {:ok, album} =
      attrs
      |> Enum.into(%{
        name: "some name",
        rating: 4.6,
        length_sec: 54 * 60,
        artist_id: artist.id,
        label_id: label.id
      })
      |> PaxDemo.Library.create_album()

    album
  end
end
