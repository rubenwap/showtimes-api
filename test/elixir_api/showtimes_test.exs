defmodule ElixirApi.ShowtimesTest do
  use ElixirApi.DataCase

  alias ElixirApi.Showtimes

  describe "movies" do
    alias ElixirApi.Showtimes.Movies

    @valid_attrs %{cinema: "some cinema", datetime: ~N[2010-04-17 14:00:00], details: "some details", title: "some title"}
    @update_attrs %{cinema: "some updated cinema", datetime: ~N[2011-05-18 15:01:01], details: "some updated details", title: "some updated title"}
    @invalid_attrs %{cinema: nil, datetime: nil, details: nil, title: nil}

    def movies_fixture(attrs \\ %{}) do
      {:ok, movies} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Showtimes.create_movies()

      movies
    end

    test "list_movies/0 returns all movies" do
      movies = movies_fixture()
      assert Showtimes.list_movies() == [movies]
    end

    test "get_movies!/1 returns the movies with given id" do
      movies = movies_fixture()
      assert Showtimes.get_movies!(movies.id) == movies
    end

    test "create_movies/1 with valid data creates a movies" do
      assert {:ok, %Movies{} = movies} = Showtimes.create_movies(@valid_attrs)
      assert movies.cinema == "some cinema"
      assert movies.datetime == ~N[2010-04-17 14:00:00]
      assert movies.details == "some details"
      assert movies.title == "some title"
    end

    test "create_movies/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Showtimes.create_movies(@invalid_attrs)
    end

    test "update_movies/2 with valid data updates the movies" do
      movies = movies_fixture()
      assert {:ok, %Movies{} = movies} = Showtimes.update_movies(movies, @update_attrs)
      assert movies.cinema == "some updated cinema"
      assert movies.datetime == ~N[2011-05-18 15:01:01]
      assert movies.details == "some updated details"
      assert movies.title == "some updated title"
    end

    test "update_movies/2 with invalid data returns error changeset" do
      movies = movies_fixture()
      assert {:error, %Ecto.Changeset{}} = Showtimes.update_movies(movies, @invalid_attrs)
      assert movies == Showtimes.get_movies!(movies.id)
    end

    test "delete_movies/1 deletes the movies" do
      movies = movies_fixture()
      assert {:ok, %Movies{}} = Showtimes.delete_movies(movies)
      assert_raise Ecto.NoResultsError, fn -> Showtimes.get_movies!(movies.id) end
    end

    test "change_movies/1 returns a movies changeset" do
      movies = movies_fixture()
      assert %Ecto.Changeset{} = Showtimes.change_movies(movies)
    end
  end
end
