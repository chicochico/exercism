defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    cond do
      Regex.match?(~r/[^0-9A-Fa-f]/, hex) -> 0
      true -> to_base_10(hex)
    end
  end

  @spec to_base_10(String.t()) :: integer
  defp to_base_10(n) when is_binary(n) do
    n
    |> String.downcase
    |> String.graphemes
    |> Enum.map(&to_integer(&1))
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.map(&to_base_10(&1, 16))
    |> Enum.sum
  end

  @spec to_base_10({integer, integer}, integer) :: integer
  defp to_base_10({n, power}, base) do
    n*:math.pow(base, power)
    |> round
  end

  @spec to_integer(String.t()) :: integer
  defp to_integer(char) do
    case char do
      "a" -> 10
      "b" -> 11
      "c" -> 12
      "d" -> 13
      "e" -> 14
      "f" -> 15
      _ -> String.to_integer(char)
    end
  end
end
