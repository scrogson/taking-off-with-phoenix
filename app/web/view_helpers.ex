defmodule Support.ViewHelpers do

  def markdown(string) do
    Earmark.to_html(string)
  end
end
