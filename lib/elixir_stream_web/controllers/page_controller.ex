defmodule ElixirStreamWeb.PageController do
  use ElixirStreamWeb, :controller

  def index(conn, _params) do
    render conn, :home
  end
end
