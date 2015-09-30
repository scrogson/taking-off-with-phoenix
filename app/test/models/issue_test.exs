defmodule Support.IssueTest do
  use Support.ModelCase

  alias Support.Issue

  @valid_attrs %{closed: true, closed_at: "2010-04-17 14:00:00", description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Issue.changeset(%Issue{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Issue.changeset(%Issue{}, @invalid_attrs)
    refute changeset.valid?
  end
end
