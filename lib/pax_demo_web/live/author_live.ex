defmodule PaxDemoWeb.AuthorLive do
  use PaxDemoWeb, :live_view
  use Pax.Interface

  def render(assigns) do
    ~H"""
    {Pax.Interface.Components.pax_interface(assigns)}
    """
  end

  def pax_adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Author}
  end

  def pax_plugins(_socket) do
    [
      Pax.Plugins.Breadcrumbs,
      Pax.Plugins.Title,
      Pax.Plugins.Pagination,
      Pax.Plugins.IndexTable,
      Pax.Plugins.DetailList,
      Pax.Plugins.NewButton
    ]
  end

  def pax_config(_socket) do
    [
      index_path: ~p"/authors",
      new_path: ~p"/authors/new",
      show_path: fn object, _socket -> ~p"/authors/#{object.id}/#{object.name}" end,
      edit_path: fn object, _socket -> ~p"/authors/#{object.id}/#{object.name}/edit" end,
      object_name: fn object, _socket -> object.name end,
      id_fields: [:id, :name],
      lookup_params: ["id", "name"],
      fields: [
        {:name, link: true},
        :birth,
        :death
      ]
    ]
  end
end
