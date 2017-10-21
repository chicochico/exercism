defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number < 1 or number > 64 do
    {:error, "The requested square must be between 1 and 64 (inclusive)"}
  end

  def square(number) do
    {:ok, :math.pow(2, number-1) |> round}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    {:ok, Enum.reduce(1..64, 0, &sum_square(&1, &2))}
  end

  defp sum_square(n, acc) do
    {:ok, sqr_grains} = square(n)
    acc + sqr_grains
  end
end
