defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    cond do
      Regex.match?(~r/[^01]/, string) -> 0
      true ->
        string
        |> String.graphemes()
        |> convert()
    end
  end

  @spec convert([String.t]) :: non_neg_integer
  def convert(number) when is_list(number) do
    number
    |> Enum.map(&String.to_integer(&1))
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {n, exp} -> (n * :math.pow(2, exp)) end)
    |> Enum.map(&round(&1))
    |> Enum.sum()
  end
end
