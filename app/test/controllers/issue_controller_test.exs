defmodule Support.IssueControllerTest do
  use Support.ConnCase

  alias Support.Issue
  @valid_attrs %{closed: true, closed_at: "2010-04-17 14:00:00", description: "some content", title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, issue_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing issues"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, issue_path(conn, :new)
    assert html_response(conn, 200) =~ "New issue"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, issue_path(conn, :create), issue: @valid_attrs
    assert redirected_to(conn) == issue_path(conn, :index)
    assert Repo.get_by(Issue, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, issue_path(conn, :create), issue: @invalid_attrs
    assert html_response(conn, 200) =~ "New issue"
  end

  test "shows chosen resource", %{conn: conn} do
    issue = Repo.insert! %Issue{}
    conn = get conn, issue_path(conn, :show, issue)
    assert html_response(conn, 200) =~ "Show issue"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, issue_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    issue = Repo.insert! %Issue{}
    conn = get conn, issue_path(conn, :edit, issue)
    assert html_response(conn, 200) =~ "Edit issue"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    issue = Repo.insert! %Issue{}
    conn = put conn, issue_path(conn, :update, issue), issue: @valid_attrs
    assert redirected_to(conn) == issue_path(conn, :show, issue)
    assert Repo.get_by(Issue, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    issue = Repo.insert! %Issue{}
    conn = put conn, issue_path(conn, :update, issue), issue: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit issue"
  end

  test "deletes chosen resource", %{conn: conn} do
    issue = Repo.insert! %Issue{}
    conn = delete conn, issue_path(conn, :delete, issue)
    assert redirected_to(conn) == issue_path(conn, :index)
    refute Repo.get(Issue, issue.id)
  end
end
