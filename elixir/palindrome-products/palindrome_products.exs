defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    for a <- min_factor..max_factor,
      b <- a..max_factor,
      palindrome?(a*b) do
      [a, b]
    end
    |> Enum.reduce(%{}, fn [a, b], acc ->
      Map.update(acc, a*b, [[a, b]], &(&1 ++ [[a, b]]))
    end)
  end

  @spec palindrome?(integer) :: boolean
  def palindrome?(n) do
    digits = Integer.digits(n)
    Enum.reverse(digits) == digits
  end
end
