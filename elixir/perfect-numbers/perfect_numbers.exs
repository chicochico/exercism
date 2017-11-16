defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: ({ :ok, atom } | { :error, String.t() })
  def classify(number) when number <= 0 do
    {:error, "Classification is only possible for natural numbers." }
  end
  def classify(number) do
    factors_sum =
      number
      |> get_factors
      |> Enum.sum

    cond do
      factors_sum == number -> {:ok, :perfect}
      factors_sum < number -> {:ok, :deficient}
      factors_sum > number -> {:ok, :abundant}
    end
  end

  @spec get_factors(integer) :: [integer]
  def get_factors(1), do: [0]
  def get_factors(number) do
    for n <- (number-1)..1, rem(number, n) == 0, do: n
  end
end

