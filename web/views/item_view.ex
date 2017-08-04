defmodule Learnit.ItemView do
  use Learnit.Web, :view

  @doc """
  Helper to load dynamic class for links

  """

  def dyn_class(title, item) do
    title <> "_" <> Kernel.inspect(item.id)
  end

end
