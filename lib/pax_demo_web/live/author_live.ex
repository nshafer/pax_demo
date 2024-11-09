defmodule PaxDemoWeb.AuthorLive do
  use PaxDemoWeb, :live_view
  use Pax.Interface
  import Pax.Interface.Components

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

  def pax_adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Author}
  end

  def pax_plugins(_socket) do
    [
      Pax.Plugins.Pagination
    ]
  end

  def pax_config(_socket) do
    [
      index_path: ~p"/authors",
      new_path: ~p"/authors/new",
      show_path: fn object, _socket -> ~p"/authors/#{object}" end,
      edit_path: fn object, _socket -> ~p"/authors/#{object}/edit" end,
      object_name: fn object, _socket -> object.name end,
      index_fields: [
        {:name, link: true},
        :birth,
        :death
      ]
    ]
  end
end
