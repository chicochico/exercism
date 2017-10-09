defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&anagram?(base, &1))
  end

  def anagram?(base, candidate) do
    base = String.downcase(base)
    candidate = String.downcase(candidate)

    b_elems =
      base
      |> String.graphemes
      |> Enum.sort

    c_elems =
      candidate
      |> String.graphemes
      |> Enum.sort

    base != candidate and b_elems == c_elems
  end
end
