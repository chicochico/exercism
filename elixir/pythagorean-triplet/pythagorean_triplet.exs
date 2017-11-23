defmodule Triplet do

  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum([a, b, c]) do
    a + b + c
  end

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product([a, b, c]) do
    a * b * c
  end

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]) do
    a*a + b*b == c*c
  end

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min \\ 1, max) do
    for s <- 1..max, t <- s..max do  # Dickson's method
        r = (2*s*t) |> :math.sqrt |> round
        [r+s, r+t, r+s+t]
    end
    |> Enum.filter(&pythagorean?(&1))
    |> Enum.filter(fn [a, _, c] ->
      cond do
        a < min or c > max -> false
        true -> true
      end
    end)
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, sum) do
    generate(min, max)
    |> Enum.filter(fn triple ->
      cond do
        sum(triple) == sum -> true
        true -> false
      end
    end)
  end
end
