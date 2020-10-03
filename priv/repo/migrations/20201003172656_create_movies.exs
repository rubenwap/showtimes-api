defmodule ElixirApi.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :cinema, :string
      add :title, :string
      add :details, :string
      add :datetime, :naive_datetime

      timestamps()
    end

  end
end
