defmodule ElixirApiWeb.MoviesControllerTest do
  use ElixirApiWeb.ConnCase

  alias ElixirApi.Showtimes
  alias ElixirApi.Showtimes.Movies

  @create_attrs %{
    cinema: "some cinema",
    datetime: ~N[2010-04-17 14:00:00],
    details: "some details",
    title: "some title"
  }
  @update_attrs %{
    cinema: "some updated cinema",
    datetime: ~N[2011-05-18 15:01:01],
    details: "some updated details",
    title: "some updated title"
  }
  @invalid_attrs %{cinema: nil, datetime: nil, details: nil, title: nil}

  def fixture(:movies) do
    {:ok, movies} = Showtimes.create_movies(@create_attrs)
    movies
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all movies", %{conn: conn} do
      conn = get(conn, Routes.movies_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create movies" do
    test "renders movies when data is valid", %{conn: conn} do
      conn = post(conn, Routes.movies_path(conn, :create), movies: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.movies_path(conn, :show, id))

      assert %{
               "id" => id,
               "cinema" => "some cinema",
               "datetime" => "2010-04-17T14:00:00",
               "details" => "some details",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.movies_path(conn, :create), movies: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update movies" do
    setup [:create_movies]

    test "renders movies when data is valid", %{conn: conn, movies: %Movies{id: id} = movies} do
      conn = put(conn, Routes.movies_path(conn, :update, movies), movies: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.movies_path(conn, :show, id))

      assert %{
               "id" => id,
               "cinema" => "some updated cinema",
               "datetime" => "2011-05-18T15:01:01",
               "details" => "some updated details",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, movies: movies} do
      conn = put(conn, Routes.movies_path(conn, :update, movies), movies: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete movies" do
    setup [:create_movies]

    test "deletes chosen movies", %{conn: conn, movies: movies} do
      conn = delete(conn, Routes.movies_path(conn, :delete, movies))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.movies_path(conn, :show, movies))
      end
    end
  end

  defp create_movies(_) do
    movies = fixture(:movies)
    %{movies: movies}
  end
end
