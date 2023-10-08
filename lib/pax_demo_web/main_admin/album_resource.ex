defmodule PaxDemoWeb.MainAdmin.AlbumResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Album, id_field: :uuid}
  end

  def index_fields(_socket) do
    [
      :id,
      {:uuid, link: true},
      {:name, link: true},
      {:rating, round: 2},
      {:length, :string, value: {__MODULE__, :length}}
    ]
  end

  def fieldsets(_socket) do
    [
      default: [
        [{:id, immutable: true}, {:uuid, immutable: true}],
        :name,
        :rating,
        :length_sec,
        :artist_id,
        {:length, :string, value: {__MODULE__, :length}}
      ]
    ]
  end

  def length(album) do
    if album.length_sec do
      min = div(album.length_sec, 60)
      sec = rem(album.length_sec, 60) |> to_string() |> String.pad_leading(2, "0")
      "#{min}:#{sec}"
    else
      "-"
    end
  end

  def object_name(object, _socket) do
    object.name
  end
end
