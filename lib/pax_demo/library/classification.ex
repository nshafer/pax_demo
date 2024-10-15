defmodule PaxDemo.Library.Classification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classifications" do
    field :name, :string
    field :short, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(classification, attrs) do
    classification
    |> cast(attrs, [:name, :short])
    |> validate_required([:name, :short])
    |> validate_length(:name, max: 255)
    |> validate_length(:short, max: 10)
  end
end
