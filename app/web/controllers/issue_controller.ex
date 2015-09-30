defmodule Support.IssueController do
  use Support.Web, :controller

  alias Support.Issue

  plug :scrub_params, "issue" when action in [:create, :update]

  def index(conn, params) do
    filter = if params["status"] == "closed", do: true, else: false
    query =
      from i in Issue,
      where: i.closed == ^filter,
      order_by: [desc: i.inserted_at],
      preload: :user

    issues = Repo.all(query)
    render(conn, "index.html", issues: issues)
  end

  def new(conn, _params) do
    changeset = Issue.changeset(%Issue{}, :insert)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"issue" => issue_params}) do
    changeset =
      build(conn.assigns.current_user, :issues)
      |> Issue.changeset(:insert, issue_params)

    case Repo.insert(changeset) do
      {:ok, _issue} ->
        conn
        |> put_flash(:info, "Issue created successfully.")
        |> redirect(to: issue_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    issue = Repo.get!(Issue, id) |> Repo.preload(:user)
    render(conn, "show.html", issue: issue)
  end

  def edit(conn, %{"id" => id}) do
    issue = Repo.get!(Issue, id)
    changeset = Issue.changeset(issue, :update)
    render(conn, "edit.html", issue: issue, changeset: changeset)
  end

  def update(conn, %{"id" => id, "issue" => issue_params}) do
    issue = Repo.get!(Issue, id)
    changeset = Issue.changeset(issue, :update, issue_params)

    case Repo.update(changeset) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue updated successfully.")
        |> redirect(to: issue_path(conn, :show, issue))
      {:error, changeset} ->
        render(conn, "edit.html", issue: issue, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    issue = Repo.get!(Issue, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(issue)

    conn
    |> put_flash(:info, "Issue deleted successfully.")
    |> redirect(to: issue_path(conn, :index))
  end
end
