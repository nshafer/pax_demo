defmodule PaxDemoWeb.LabelLive.Detail do
  use PaxDemoWeb, :live_view
  use Pax.Detail.Live

  def render(assigns) do
    IO.inspect(assigns, label: "assigns")

    ~H"""
    <h1 class="text-2xl mb-3">Label</h1>
    <Pax.Detail.Components.detail fields={@fields} object={@object} />
    """
  end

  def adapter(_params, _session, _socket) do
    {Pax.SchemaAdapter, repo: PaxDemo.Repo, schema: PaxDemo.Library.Label}
  end
end
