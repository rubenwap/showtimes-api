defmodule ElixirApiWeb.MoviesController do
  use ElixirApiWeb, :controller

  alias ElixirApi.Showtimes
  alias ElixirApi.Showtimes.Movies

  action_fallback ElixirApiWeb.FallbackController

  def index(conn, _params) do
    movies = Showtimes.list_movies()
    render(conn, "index.json", movies: movies)
  end

  def create(conn, %{"movies" => movies_params}) do
    with {:ok, %Movies{} = movies} <- Showtimes.create_movies(movies_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.movies_path(conn, :show, movies))
      |> render("show.json", movies: movies)
    end
  end

  def show(conn, %{"id" => id}) do
    movies = Showtimes.get_movies!(id)
    render(conn, "show.json", movies: movies)
  end

  def update(conn, %{"id" => id, "movies" => movies_params}) do
    movies = Showtimes.get_movies!(id)

    with {:ok, %Movies{} = movies} <- Showtimes.update_movies(movies, movies_params) do
      render(conn, "show.json", movies: movies)
    end
  end

  def delete(conn, %{"id" => id}) do
    movies = Showtimes.get_movies!(id)

    with {:ok, %Movies{}} <- Showtimes.delete_movies(movies) do
      send_resp(conn, :no_content, "")
    end
  end
end
