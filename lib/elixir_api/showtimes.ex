defmodule ElixirApi.Showtimes do
  @moduledoc """
  The Showtimes context.
  """

  import Ecto.Query, warn: false
  alias ElixirApi.Repo

  alias ElixirApi.Showtimes.Movies

  @doc """
  Returns the list of movies.

  ## Examples

      iex> list_movies()
      [%Movies{}, ...]

  """
  def list_movies do
    Repo.all(Movies)
  end

  @doc """
  Gets a single movies.

  Raises `Ecto.NoResultsError` if the Movies does not exist.

  ## Examples

      iex> get_movies!(123)
      %Movies{}

      iex> get_movies!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movies!(id), do: Repo.get!(Movies, id)

  @doc """
  Creates a movies.

  ## Examples

      iex> create_movies(%{field: value})
      {:ok, %Movies{}}

      iex> create_movies(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movies(attrs \\ %{}) do
    %Movies{}
    |> Movies.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a movies.

  ## Examples

      iex> update_movies(movies, %{field: new_value})
      {:ok, %Movies{}}

      iex> update_movies(movies, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movies(%Movies{} = movies, attrs) do
    movies
    |> Movies.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a movies.

  ## Examples

      iex> delete_movies(movies)
      {:ok, %Movies{}}

      iex> delete_movies(movies)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movies(%Movies{} = movies) do
    Repo.delete(movies)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movies changes.

  ## Examples

      iex> change_movies(movies)
      %Ecto.Changeset{data: %Movies{}}

  """
  def change_movies(%Movies{} = movies, attrs \\ %{}) do
    Movies.changeset(movies, attrs)
  end
end
