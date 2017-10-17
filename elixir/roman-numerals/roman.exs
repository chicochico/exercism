defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(n), do: numerals(n, "")
  def numerals(0, acc), do: acc
  def numerals(1, acc), do: acc <> "I"
  def numerals(2, acc), do: acc <> "II"
  def numerals(3, acc), do: acc <> "III"
  def numerals(4, acc), do: acc <> "IV"
  def numerals(6, acc), do: acc <> "VI"
  def numerals(7, acc), do: acc <> "VII"
  def numerals(8, acc), do: acc <> "VIII"
  def numerals(9, acc), do: acc <> "IX"
  def numerals(n, acc) when n >= 1000, do: acc <> "M" <> numerals(n-1000)
  def numerals(n, acc) when n >= 900, do: acc <> "CM" <> numerals(n-900)
  def numerals(n, acc) when n >= 500, do: acc <> "D" <> numerals(n-500)
  def numerals(n, acc) when n >= 400, do: acc <> "CD" <> numerals(n-400)
  def numerals(n, acc) when n >= 100, do: acc <> "C" <> numerals(n-100)
  def numerals(n, acc) when n >= 90, do: acc <> "XC" <> numerals(n-90)
  def numerals(n, acc) when n >= 50, do: acc <> "L" <> numerals(n-50)
  def numerals(n, acc) when n >= 40, do: acc <> "XL" <> numerals(n-40)
  def numerals(n, acc) when n >= 10, do: acc <> "X" <> numerals(n-10)
  def numerals(n, acc) when n >= 5, do: acc <> "V" <> numerals(n-5)
end
