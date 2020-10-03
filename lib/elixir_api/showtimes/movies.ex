defmodule ElixirApi.Showtimes.Movies do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "movies" do
    field :cinema, :string
    field :datetime, :naive_datetime
    field :details, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(movies, attrs) do
    movies
    |> cast(attrs, [:cinema, :title, :details, :datetime])
    |> validate_required([:cinema, :title, :details, :datetime])
  end
end
