defmodule Support.IssueView do
  use Support.Web, :view

  alias Support.Issue

  def status(issue) do
    if issue.closed, do: "Closed", else: "Open"
  end

  def status_label(issue) do
    label = if issue.closed, do: "danger", else: "success"
    content_tag :span, class: "label label-#{label}" do
      status(issue)
    end
  end

  def close_or_reopen_button(%Issue{closed: closed}) do
    {val, label} = if closed, do: {"0", "Reopen"}, else: {"1", "Close"}
    content_tag :button, name: "issue[closed]", value: val, class: "btn btn-default" do
      label
    end
  end
end
