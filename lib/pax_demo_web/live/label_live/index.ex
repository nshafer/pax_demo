defmodule PaxDemoWeb.LabelLive.Index do
  use PaxDemoWeb, :live_view
  use Pax.Index.Live

  def render(assigns) do
    IO.inspect(assigns, label: "assigns")

    ~H"""
    <h1 class="text-2xl mb-3">Labels</h1>
    <Pax.Index.Components.index fields={@fields} objects={@objects} />
    """
  end

  def adapter(_params, _session, _socket) do
    {Pax.SchemaAdapter, repo: PaxDemo.Repo, schema: PaxDemo.Library.Label}
  end

  def fields(_params, _session, _socket) do
    [
      {:id, :integer, link: true},
      {:name, :string, link: true},
      {:name_cap, :string, value: fn l -> String.upcase(l.name) end},
      {:rating, :string, value: {__MODULE__, :format_rating}},
      {:rating_f, :float, title: "Rating!", round: 2, value: :rating},
      {:accepting_submissions, :boolean, true: "Yes", false: "No"},
      {:inserted_at, :datetime},
      {:updated_at, :datetime}
    ]
  end

  def format_rating(%{rating: nil}), do: "-"
  def format_rating(%{rating: rating}), do: rating |> Float.round(1) |> Float.to_string()

  # def on_mount(arg, params, session, socket) do
  #   IO.puts("#{__MODULE__}.on_mount(#{inspect(arg)}, #{inspect(params)}, #{inspect(session)}")

  #   {:cont, socket}
  # end

  # on_mount __MODULE__

  # def mount(params, session, socket) do
  #   IO.puts("#{__MODULE__}.mount(#{inspect(params)}, #{inspect(session)}")

  #   {:ok, socket}
  # end

  # def handle_params(params, uri, socket) do
  #   IO.puts("#{__MODULE__}.handle_params(#{inspect(params)}, #{inspect(uri)}")

  #   {:noreply, socket}
  # end
end
