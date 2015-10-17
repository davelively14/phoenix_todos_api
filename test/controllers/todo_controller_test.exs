defmodule PhoenixTodosApi.TodoControllerTest do
  use PhoenixTodosApi.ConnCase

  alias PhoenixTodosApi.Todo
  @valid_attrs %{is_completed: true, title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, todo_path(conn, :index)
    assert json_response(conn, 200)["todos"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    todo = Repo.insert! %Todo{}
    conn = get conn, todo_path(conn, :show, todo)
    assert json_response(conn, 200)["todo"] == %{"id" => todo.id,
      "title" => todo.title,
      "is_completed" => todo.is_completed}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, todo_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when todo is valid", %{conn: conn} do
    conn = post conn, todo_path(conn, :create), todo: @valid_attrs
    assert json_response(conn, 201)["todo"]["id"]
    assert Repo.get_by(Todo, @valid_attrs)
  end

  test "does not create resource and renders errors when todo is invalid", %{conn: conn} do
    conn = post conn, todo_path(conn, :create), todo: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when todo is valid", %{conn: conn} do
    todo = Repo.insert! %Todo{}
    conn = put conn, todo_path(conn, :update, todo), todo: @valid_attrs
    assert json_response(conn, 200)["todo"]["id"]
    assert Repo.get_by(Todo, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when todo is invalid", %{conn: conn} do
    todo = Repo.insert! %Todo{}
    conn = put conn, todo_path(conn, :update, todo), todo: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    todo = Repo.insert! %Todo{}
    conn = delete conn, todo_path(conn, :delete, todo)
    assert response(conn, 204)
    refute Repo.get(Todo, todo.id)
  end
end
