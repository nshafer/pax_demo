defmodule PaxDemoWeb.AlbumLive do
  use PaxDemoWeb, :live_view
  use Pax.Interface
  import Pax.Interface.Components

  @impl true
  def render(assigns) do
    ~H"""
    <%= if assigns[:pax] do %>
      <.pax_index :if={@live_action == :index} pax={@pax} />
      <.pax_show :if={@live_action == :show} pax={@pax} />
      <.pax_new :if={@live_action == :new} pax={@pax} />
      <.pax_edit :if={@live_action == :edit} pax={@pax} />
    <% else %>
      Loading...
    <% end %>
    """
  end

  @impl true
  def adapter(_socket),
    do: {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Album, id_field: :uuid}

  @impl true
  def plugins(_socket) do
    [
      Pax.Plugins.Pagination
      # {Pax.Plugins.Pagination, objects_per_page: 4}
    ]
  end

  @impl true
  def pax_config(_socket) do
    [
      index_path: ~p"/albums",
      new_path: ~p"/albums/new",
      show_path: fn object, _socket -> ~p"/albums/#{object.uuid}" end,
      edit_path: fn object, _socket -> ~p"/albums/#{object.uuid}/edit" end,
      object_name: fn object, _socket -> object.name end,
      objects_per_page: 20,
      index_fields: [
        :id,
        {:name, link: true},
        :rating,
        :length_sec
        # :inserted_at,
        # {:updated_at, :datetime, format: "%Y-%m-%d %H:%M:%S"}
      ],
      fieldsets: [
        default: [
          :name,
          [:rating, :length_sec]
        ],
        metadata: [
          [
            {:id, immutable: true},
            {:uuid, immutable: true},
            {:inserted_at, :datetime, immutable: true},
            {:updated_at, :datetime, immutable: true}
          ]
        ]
      ]
    ]
  end

  def format_rating(%{rating: nil}), do: "-"
  def format_rating(%{rating: rating}), do: rating |> Float.round(1) |> Float.to_string()
end
