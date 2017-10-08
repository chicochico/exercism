defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..limit-1
    |> Enum.filter(&(is_multiple?(&1, factors)))
    |> Enum.sum
  end

  defp is_multiple?(n, factors) when is_list factors do
    factors
    |> Enum.any?(&(rem(n, &1) == 0))
  end
end
