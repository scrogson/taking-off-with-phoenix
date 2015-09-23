defmodule Support.PageController do
  use Support.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
