defmodule PaxDemo.Library.Language do
  use Ecto.Schema
  import Ecto.Changeset

  schema "languages" do
    field :name, :string
    field :short, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(language, attrs) do
    language
    |> cast(attrs, [:name, :short])
    |> validate_required([:name, :short])
    |> validate_length(:name, max: 255)
    |> validate_length(:short, max: 3)
  end
end
