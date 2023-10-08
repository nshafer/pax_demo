defmodule PaxDemoWeb.LabelLive do
  use PaxDemoWeb, :live_view
  use Pax.Interface

  @impl true
  def render(assigns) do
    # dbg(assigns.pax)

    ~H"""
    <Pax.Interface.Components.index :if={@live_action == :index} pax={@pax} objects={@objects} />
    <Pax.Interface.Components.show :if={@live_action == :show} pax={@pax} object={@object} />
    <Pax.Interface.Components.edit :if={@live_action in [:edit, :new]} pax={@pax} object={@object} form={@form} />
    """
  end

  @impl true
  def adapter(_socket),
    do: {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Label}

  @impl true
  def index_path(_socket), do: ~p"/labels/"

  @impl true
  def new_path(_socket), do: ~p"/labels/new"

  @impl true
  def show_path(object, _socket), do: ~p"/labels/#{object.id}"

  @impl true
  def edit_path(object, _socket), do: ~p"/labels/#{object.id}/edit"

  @impl true
  def object_name(object, _socket), do: object.name

  @impl true
  def index_fields(_socket) do
    [
      :id,
      {:name, link: true},
      # :name,
      :founded,
      :rating,
      :accepting_submissions
      # :inserted_at,
      # {:updated_at, :datetime, format: "%Y-%m-%d %H:%M:%S"}
    ]
  end

  @impl true
  def fieldsets(_socket) do
    [
      [
        :name,
        :slug
      ],
      [
        :founded,
        {:rating, :float, title: "Rating (0-5)", round: 2, required: false}
      ],
      {:accepting_submissions, :boolean, true: "Yes", false: "No"},
      {:inserted_at, :datetime, immutable: true},
      {:updated_at, :datetime, immutable: true}
    ]
  end

  def format_rating(%{rating: nil}), do: "-"
  def format_rating(%{rating: rating}), do: rating |> Float.round(1) |> Float.to_string()
end
