defmodule PaxDemoWeb.MainAdmin.AlbumResource do
  use Pax.Admin.Resource

  def pax_adapter(_params, _session, _socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Album}
  end

  def pax_index_fields(_params, _session, _socket) do
    [
      :id,
      {:uuid, link: true},
      {:name, link: true},
      {:rating, round: 2},
      {:length, :string, value: {__MODULE__, :length}}
    ]
  end

  def pax_detail_fieldsets(_params, _session, _socket) do
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

  def index_link(object, resource) do
    case resource.section do
      nil -> PaxDemoWeb.MainAdmin.Site.resource_show_path(resource.name, object, :uuid)
      section -> PaxDemoWeb.MainAdmin.Site.resource_show_path(section.name, resource.name, object, :uuid)
    end
  end

  def pax_lookup(query, %{"id" => id}, _uri, _socket) do
    import Ecto.Query
    from q in query, where: q.uuid == ^id
  end

  def detail_title(object) do
    object.name
  end
end
