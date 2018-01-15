defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t}
  def in_english(number) when (number < 0) or (number > 999_999_999_999) do
    {:error, "number is out of range"}
  end

  def in_english(number) do
    translated =
      number
      |> chunk
      |> Enum.map(&to_english(&1))
      |> Enum.join("\s")
    {:ok, translated}
  end

  @spec chunk(integer) :: [integer | {integer, integer}]
  def chunk(number) do
    []
    |> chunk(number)
    |> Enum.reverse
  end

  @spec chunk(list, integer) :: [integer | {integer, integer}]
  def chunk(chunks, number) do
    cond do
      number <= 20 ->
        {number, 0}
      number < 100 ->
        {div(number, 10) * 10, rem(number, 10)}
      number < 1000 ->
        {div(number, 100), 100, rem(number, 100)}
      number < 1_000_000 ->
        {div(number, 1000), 1000, rem(number, 1000)}
      number < 1_000_000_000 ->
        {div(number, 1_000_000), 1_000_000, rem(number, 1_000_000)}
      number < 1_000_000_000_000 ->
        {div(number, 1_000_000_000), 1_000_000_000, rem(number, 1_000_000_000)}
    end
    |> case do
      {n, 0} ->
        [n | chunks]
      {n, remainder} when n < 100 and remainder < 10 ->
        [{n, remainder}| chunks]
      {n, remainder} ->
        [n | chunks]
        |> chunk(remainder)
      {n, base, 0} ->
        chunks
        |>chunk(n)
        |> List.insert_at(0, base)
      {n, base, remainder} ->
        chunks
        |> chunk(n)
        |> List.insert_at(0, base)
        |> chunk(remainder)
    end
  end

  @spec to_english(integer) :: String.t
  def to_english(number) do
    case number do
      0 -> "zero"
      1 -> "one"
      2 -> "two"
      3 -> "three"
      4 -> "four"
      5 -> "five"
      6 -> "six"
      7 -> "seven"
      8 -> "eight"
      9 -> "nine"
      10 -> "ten"
      11 -> "eleven"
      12 -> "twelve"
      13 -> "thirteen"
      14 -> "fourteen"
      15 -> "fifhteen"
      16 -> "sixteen"
      17 -> "seventeen"
      18 -> "eighteen"
      19 -> "nineteen"
      20 -> "twenty"
      30 -> "thirty"
      40 -> "forty"
      50 -> "fifty"
      60 -> "sixty"
      70 -> "seventy"
      80 -> "eighty"
      90 -> "ninety"
      100 -> "hundred"
      1_000 -> "thousand"
      1_000_000 -> "million"
      1_000_000_000 -> "billion"
      1_000_000_000_000 -> "trillion"
      {n, n2} -> to_english(n) <> "-" <> to_english(n2)
    end
  end
end
