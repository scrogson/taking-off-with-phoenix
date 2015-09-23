defmodule Support.CurrentUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    assign(conn, :current_user, user_from_session(conn))
  end

  defp user_from_session(conn) do
    case get_session(conn, :current_user) do
      nil -> nil
      val -> Support.Repo.get(Support.User, val)
    end
  end
end
