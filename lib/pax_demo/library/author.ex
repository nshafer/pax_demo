defmodule PaxDemo.Library.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :name, :string
    field :birth, :integer
    field :death, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :birth, :death])
    |> validate_required([:name, :birth, :death])
    |> validate_length(:name, max: 255)
  end
end
