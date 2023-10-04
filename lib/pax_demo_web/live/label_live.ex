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
  def pax_adapter(_socket),
    do: {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Label}

  @impl true
  def pax_index_path(_socket), do: ~p"/labels/"

  @impl true
  def pax_new_path(_socket), do: ~p"/labels/new"

  @impl true
  # TODO: remove pax_field_link and instead use show_path or edit_path, if defined?
  def pax_field_link(%{id: id}), do: ~p"/labels/#{id}"

  @impl true
  def pax_show_path(_socket, object), do: ~p"/labels/#{object.id}"

  @impl true
  def pax_edit_path(_socket, object), do: ~p"/labels/#{object.id}/edit"

  @impl true
  def pax_object_name(_socket, object), do: object.name

  @impl true
  def pax_fields(_socket) do
    [
      :id,
      {:name, link: true},
      :founded,
      :rating,
      :accepting_submissions
      # :inserted_at,
      # {:updated_at, :datetime, format: "%Y-%m-%d %H:%M:%S"}
    ]
  end

  @impl true
  def pax_fieldsets(_socket) do
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
