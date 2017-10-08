defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a == b -> :equal
      is_sublist?(a, b) -> :sublist
      is_sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  def is_sublist?(a, []), do: false
  def is_sublist?(a, [_|t] = b) do
    case List.starts_with?(b, a) do
      true -> true
      false -> is_sublist?(a, t)
    end
  end
end
