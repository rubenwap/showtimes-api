defmodule ElixirApiWeb.MoviesView do
  use ElixirApiWeb, :view
  alias ElixirApiWeb.MoviesView

  def render("index.json", %{movies: movies}) do
    %{data: render_many(movies, MoviesView, "movies.json")}
  end

  def render("show.json", %{movies: movies}) do
    %{data: render_one(movies, MoviesView, "movies.json")}
  end

  def render("movies.json", %{movies: movies}) do
    %{id: movies.id,
      cinema: movies.cinema,
      title: movies.title,
      details: movies.details,
      datetime: movies.datetime}
  end
end
