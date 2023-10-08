defmodule PaxDemoWeb.PartnerAdmin.AlbumResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Album}
  end

  def index_fields(_socket) do
    [
      {:name, link: true},
      {:rating, round: 2},
      {:length, :string, value: {__MODULE__, :length}}
    ]
  end

  def fieldsets(_socket) do
    [
      default: [
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
end
