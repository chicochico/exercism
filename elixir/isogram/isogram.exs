defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    clean =
      sentence
      |> String.replace(" ", "")
      |> String.replace("-", "")

    set =
      clean
      |> to_charlist
      |> MapSet.new

    String.length(clean) == MapSet.size(set)
  end
end
