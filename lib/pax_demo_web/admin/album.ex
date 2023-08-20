defmodule PaxDemoWeb.Admin.Album do
  use Pax.Admin.Resource

  def pax_adapter(_params, _session, _socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Album}
  end

  def pax_index_fields(_params, _session, _socket) do
    [
      {:id, :integer},
      {:uuid, :string},
      {:name, :string},
      {:rating, :float, title: "Rating!", round: 2},
      {:length, :string, value: {__MODULE__, :length}}
    ]
  end

  def pax_detail_fieldsets(_params, _session, _socket) do
    [
      default: [
        [{:id, :integer}, {:uuid, :string}],
        {:name, :string},
        {:rating, :float, round: 2},
        {:length, :string, value: {__MODULE__, :length}}
      ]
    ]
  end

  def length(album) do
    min = div(album.length_sec, 60)
    sec = rem(album.length_sec, 60) |> to_string() |> String.pad_leading(2, "0")
    "#{min}:#{sec}"
  end

  def lookup(query, %{"id" => id}, _uri, _socket) do
    import Ecto.Query
    from q in query, where: q.id == ^id
  end
end
