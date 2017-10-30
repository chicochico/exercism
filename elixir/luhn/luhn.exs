defmodule Luhn do

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number = clean(number)

    cond do
      String.length(number) < 2 -> false
      String.match?(number, ~r/[^0-9]/) -> false
      true -> check(number)
    end
  end

  def check(number) do
    sum =
      number
      |> String.graphemes
      |> Enum.map(&String.to_integer(&1))
      |> Kernel.++([0])
      |> Enum.reverse
      |> Enum.map_every(2, &(&1*2))
      |> Enum.map(fn n -> if n > 9, do: n-9, else: n end)
      |> Enum.sum

    case rem(sum, 10) do
      0 -> true
      _ -> false
    end
  end

  def clean(number) do
    number
    |> String.replace(" ", "")
  end
end
