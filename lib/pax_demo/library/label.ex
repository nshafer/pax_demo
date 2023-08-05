defmodule PaxDemo.Library.Label do
  use Ecto.Schema
  import Ecto.Changeset

  schema "labels" do
    field :name, :string
    field :slug, :string
    field :rating, :float
    field :founded, :integer
    field :accepting_submissions, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(label, attrs) do
    label
    |> cast(attrs, [:name, :rating, :founded, :accepting_submissions])
    |> validate_required([:name, :founded, :accepting_submissions])
  end
end
