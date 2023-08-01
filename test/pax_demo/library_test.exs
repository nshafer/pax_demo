defmodule PaxDemo.LibraryTest do
  use PaxDemo.DataCase

  alias PaxDemo.Library

  describe "labels" do
    alias PaxDemo.Library.Label

    import PaxDemo.LibraryFixtures

    @invalid_attrs %{name: nil, rating: nil, founded: nil, accepting_submissions: nil}

    test "list_labels/0 returns all labels" do
      label = label_fixture()
      assert Library.list_labels() == [label]
    end

    test "get_label!/1 returns the label with given id" do
      label = label_fixture()
      assert Library.get_label!(label.id) == label
    end

    test "create_label/1 with valid data creates a label" do
      valid_attrs = %{name: "some name", rating: 120.5, founded: 42, accepting_submissions: true}

      assert {:ok, %Label{} = label} = Library.create_label(valid_attrs)
      assert label.name == "some name"
      assert label.rating == 120.5
      assert label.founded == 42
      assert label.accepting_submissions == true
    end

    test "create_label/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_label(@invalid_attrs)
    end

    test "update_label/2 with valid data updates the label" do
      label = label_fixture()

      update_attrs = %{
        name: "some updated name",
        rating: 456.7,
        founded: 43,
        accepting_submissions: false
      }

      assert {:ok, %Label{} = label} = Library.update_label(label, update_attrs)
      assert label.name == "some updated name"
      assert label.rating == 456.7
      assert label.founded == 43
      assert label.accepting_submissions == false
    end

    test "update_label/2 with invalid data returns error changeset" do
      label = label_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_label(label, @invalid_attrs)
      assert label == Library.get_label!(label.id)
    end

    test "delete_label/1 deletes the label" do
      label = label_fixture()
      assert {:ok, %Label{}} = Library.delete_label(label)
      assert_raise Ecto.NoResultsError, fn -> Library.get_label!(label.id) end
    end

    test "change_label/1 returns a label changeset" do
      label = label_fixture()
      assert %Ecto.Changeset{} = Library.change_label(label)
    end
  end

  describe "artists" do
    alias PaxDemo.Library.Artist

    import PaxDemo.LibraryFixtures

    @invalid_attrs %{name: nil, started: nil, rating: nil, ended: nil}

    test "list_artists/0 returns all artists" do
      artist = artist_fixture()
      assert Library.list_artists() == [artist]
    end

    test "get_artist!/1 returns the artist with given id" do
      artist = artist_fixture()
      assert Library.get_artist!(artist.id) == artist
    end

    test "create_artist/1 with valid data creates a artist" do
      valid_attrs = %{
        name: "some name",
        started: ~N[2023-07-30 23:55:00],
        rating: 120.5,
        ended: ~N[2023-07-30 23:55:00]
      }

      assert {:ok, %Artist{} = artist} = Library.create_artist(valid_attrs)
      assert artist.name == "some name"
      assert artist.started == ~N[2023-07-30 23:55:00]
      assert artist.rating == 120.5
      assert artist.ended == ~N[2023-07-30 23:55:00]
    end

    test "create_artist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_artist(@invalid_attrs)
    end

    test "update_artist/2 with valid data updates the artist" do
      artist = artist_fixture()

      update_attrs = %{
        name: "some updated name",
        started: ~N[2023-07-31 23:55:00],
        rating: 456.7,
        ended: ~N[2023-07-31 23:55:00]
      }

      assert {:ok, %Artist{} = artist} = Library.update_artist(artist, update_attrs)
      assert artist.name == "some updated name"
      assert artist.started == ~N[2023-07-31 23:55:00]
      assert artist.rating == 456.7
      assert artist.ended == ~N[2023-07-31 23:55:00]
    end

    test "update_artist/2 with invalid data returns error changeset" do
      artist = artist_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_artist(artist, @invalid_attrs)
      assert artist == Library.get_artist!(artist.id)
    end

    test "delete_artist/1 deletes the artist" do
      artist = artist_fixture()
      assert {:ok, %Artist{}} = Library.delete_artist(artist)
      assert_raise Ecto.NoResultsError, fn -> Library.get_artist!(artist.id) end
    end

    test "change_artist/1 returns a artist changeset" do
      artist = artist_fixture()
      assert %Ecto.Changeset{} = Library.change_artist(artist)
    end
  end

  describe "albums" do
    alias PaxDemo.Library.Album

    import PaxDemo.LibraryFixtures

    @invalid_attrs %{name: nil, rating: nil, length_sec: nil}

    test "list_albums/0 returns all albums" do
      album = album_fixture()
      assert Library.list_albums() == [album]
    end

    test "get_album!/1 returns the album with given id" do
      album = album_fixture()
      assert Library.get_album!(album.id) == album
    end

    test "create_album/1 with valid data creates a album" do
      label = label_fixture()
      artist = artist_fixture()

      valid_attrs = %{
        name: "some name",
        rating: 120.5,
        length_sec: 42,
        label_id: label.id,
        artist_id: artist.id
      }

      assert {:ok, %Album{} = album} = Library.create_album(valid_attrs)
      assert album.name == "some name"
      assert album.rating == 120.5
      assert album.length_sec == 42
      assert album.label_id == label.id
      assert album.artist_id == artist.id
    end

    test "create_album/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_album(@invalid_attrs)
    end

    test "update_album/2 with valid data updates the album" do
      album = album_fixture()
      update_attrs = %{name: "some updated name", rating: 456.7, length_sec: 43}

      assert {:ok, %Album{} = album} = Library.update_album(album, update_attrs)
      assert album.name == "some updated name"
      assert album.rating == 456.7
      assert album.length_sec == 43
    end

    test "update_album/2 with invalid data returns error changeset" do
      album = album_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_album(album, @invalid_attrs)
      assert album == Library.get_album!(album.id)
    end

    test "delete_album/1 deletes the album" do
      album = album_fixture()
      assert {:ok, %Album{}} = Library.delete_album(album)
      assert_raise Ecto.NoResultsError, fn -> Library.get_album!(album.id) end
    end

    test "change_album/1 returns a album changeset" do
      album = album_fixture()
      assert %Ecto.Changeset{} = Library.change_album(album)
    end
  end
end
