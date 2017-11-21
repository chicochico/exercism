defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    cond do
      size == 0 -> 1
      size > String.length(number_string) -> raise ArgumentError
      size < 0 -> raise ArgumentError
      true ->
        number_string
        |> String.graphemes
        |> Enum.map(&String.to_integer(&1))
        |> find_largest_product(size)
    end
  end

  @spec find_largest_product([integer], integer) :: integer
  defp find_largest_product(numbers, size) do
    numbers
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(&product(&1))
    |> Enum.max
  end

  @spec product([integer]) :: integer
  defp product(numbers) do
    numbers
    |> Enum.reduce(1, &(&1*&2))
  end
end
