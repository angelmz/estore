defmodule EstoreWeb.PageController do
  use EstoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
