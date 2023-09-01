defmodule PaxDemoWeb.Admin.ArtistResource do
  use Pax.Admin.Resource

  def pax_adapter(_params, _session, _socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Artist}
  end

  # def pax_index_fields(_params, _session, _socket) do
  #   [:id, {:name, link: true}, :rating, :started, :ended]
  # end

  # def pax_detail_fieldsets(_params, _session, _socket) do
  #   [
  #     [:name, :slug],
  #     :rating,
  #     [:started, :ended],
  #     :current_label_id
  #   ]
  # end

  # def pax_detail_fieldsets(_params, _session, _socket) do
  #   [
  #     [{:name, :string}, {:slug, :string}],
  #     {:rating, :float, round: 2},
  #     [{:started, :datetime}, {:ended, :datetime}],
  #     {:current_label_id, :integer}
  #   ]
  # end
end
