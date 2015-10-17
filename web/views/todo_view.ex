defmodule PhoenixTodosApi.TodoView do
  use PhoenixTodosApi.Web, :view

  def render("index.json", %{todos: todos}) do
    %{todos: render_many(todos, PhoenixTodosApi.TodoView, "todo.json")}
  end

  def render("show.json", %{todo: todo}) do
    %{todo: render_one(todo, PhoenixTodosApi.TodoView, "todo.json")}
  end

  def render("todo.json", %{todo: todo}) do
    %{id: todo.id,
      title: todo.title,
      is_completed: todo.is_completed}
  end
end
