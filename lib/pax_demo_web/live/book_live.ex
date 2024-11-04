defmodule PaxDemoWeb.BookLive do
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

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Book}
  end

  def plugins(_socket) do
    [
      Pax.Plugins.Pagination
    ]
  end

  def pax_config(_socket) do
    [
      index_path: ~p"/books",
      new_path: ~p"/books/new",
      show_path: fn object, _socket -> ~p"/books/#{object}" end,
      edit_path: fn object, _socket -> ~p"/books/#{object}/edit" end,
      object_name: fn object, _socket -> object.title end,
      index_fields: [
        {:title, link: true},
        :rank,
        :downloads,
        :reading_level,
        :publication_date
      ]
    ]
  end
end
