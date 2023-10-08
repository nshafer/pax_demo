defmodule PaxDemoWeb.MainAdmin.ArtistResource do
  use Pax.Admin.Resource

  def adapter(_socket) do
    {Pax.Adapters.EctoSchema, repo: PaxDemo.Repo, schema: PaxDemo.Library.Artist}
  end

  # def index_fields(_socket) do
  #   [:id, {:name, link: true}, :rating, :started, :ended]
  # end

  # def fieldsets(_socket) do
  #   [
  #     [:name, :slug],
  #     :rating,
  #     [:started, :ended],
  #     :current_label_id
  #   ]
  # end

  # def fieldsets(_socket) do
  #   [
  #     [{:name, :string}, {:slug, :string}],
  #     {:rating, :float, round: 2},
  #     [{:started, :datetime}, {:ended, :datetime}],
  #     {:current_label_id, :integer}
  #   ]
  # end
end
