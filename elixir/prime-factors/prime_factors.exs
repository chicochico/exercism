defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number), do: factors_for(number, 2, [])
  def factors_for(1, _factor, acc), do: acc
  def factors_for(number, factor, acc) do
    cond do
      rem(number, factor) == 0 ->
        number/factor
        |> round
        |> factors_for(2, acc ++ [factor])
      true -> factors_for(number, factor+1, acc)
    end
  end
end
