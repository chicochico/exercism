defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _, _), do: nil
  def convert(_, base_a, _) when base_a < 2, do: nil
  def convert(_, _, base_b) when base_b < 2, do: nil
  def convert([0|[]], _, _), do: [0]
  def convert([0|t], base_a, base_b), do: convert(t, base_a, base_b)
  def convert(number, base_a, 10) do
    if valid?(number, base_a) do
      number
      |> Enum.zip(length(number)-1..0)
      |> Enum.reduce(0, &(&2 + to_base_10(&1, base_a)))
      |> split_decimal
    end
  end
  def convert(number, 10, base_b) do
    if valid?(number, 10) do
      number
      |> Enum.join
      |> String.to_integer
      |> from_base_10(base_b)
    end
  end
  def convert(number, base_a, base_b) do
    if valid?(number, base_a) do
      number
      |> convert(base_a, 10)
      |> Enum.join
      |> String.to_integer
      |> from_base_10(base_b)
    end
  end

  def from_base_10(n, base), do: from_base_10(n, base, [])
  def from_base_10(0, _, acc), do: acc
  def from_base_10(n, base, acc) do
    n/base
    |> :math.floor
    |> round
    |> from_base_10(base, [rem(n, base)] ++ acc)
  end

  def to_base_10({n, power}, base) do
    n*:math.pow(base, power)
    |> round
  end

  def split_decimal(n), do: split_decimal(n, [])
  def split_decimal(0, acc), do: acc
  def split_decimal(n, acc) do
    n/10
    |> :math.floor
    |> round
    |> split_decimal([rem(n, 10)] ++ acc)
  end

  def valid?(number, base_a) do
    !Enum.any?(number, &(&1 > base_a-1 or &1 < 0))
  end
end
