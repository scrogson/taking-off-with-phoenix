defmodule Workshop.PageController do
  use Workshop.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
