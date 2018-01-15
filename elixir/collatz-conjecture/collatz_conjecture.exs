defmodule CollatzConjecture do

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(number :: pos_integer) :: pos_integer
  def calc(input) when input > 0 and is_integer(input) do
    calc(input, 0)
  end

  def calc(1, steps), do: steps

  def calc(input, step) do
    cond do
      rem(input, 2) == 0 ->
        input
        |> div(2)
        |> calc(step+1)
      true ->
        ((input * 3) + 1)
        |> calc(step+1)
    end
  end
end
