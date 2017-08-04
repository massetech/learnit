defmodule Learnit.ItemlistView do
  use Learnit.Web, :view

  def dyn_class(title, item) do
    title <> "_" <> Kernel.inspect(item.id)
  end

end
