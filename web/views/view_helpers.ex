defmodule Learnit.ViewHelpers do

  @doc """
  Helper to load dynamic class for links
  """
  def dyn_class(title, item) do
    title <> "_" <> Kernel.inspect(item.id)
  end


end
