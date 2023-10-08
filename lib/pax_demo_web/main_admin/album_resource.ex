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
        [:id, :uuid],
        :name,
        :rating,
        :length_sec,
        {:length, :string, value: {__MODULE__, :length}}
      ]
    ]
  end

  def length(album) do
    min = div(album.length_sec, 60)
    sec = rem(album.length_sec, 60) |> to_string() |> String.pad_leading(2, "0")
    "#{min}:#{sec}"
  end

  def object_name(_socket, object) do
    object.name
  end
end
