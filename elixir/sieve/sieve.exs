defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    2..limit
    |> Enum.to_list
    |> primes_to([])
    |> Enum.reverse
  end

  @spec primes_to(list, list) :: list
  def primes_to([], acc), do: acc
  def primes_to([h|t], acc) do
    (for n <- t, rem(n, h) != 0, do: n)
    |> primes_to([h | acc])
  end
end
