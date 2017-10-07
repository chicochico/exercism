defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    conversion = ""
      |> raindrop(number, :pling)
      |> raindrop(number, :plang)
      |> raindrop(number, :plong)

    if conversion == "" do
      Integer.to_string(number)
    else
      conversion
    end
  end

  def raindrop(str, n, drop) do
    case drop do
      :pling ->
        if divisible_by(n, 3), do: str <> "Pling", else: str
      :plang ->
        if divisible_by(n, 5), do: str <> "Plang", else: str
      :plong ->
        if divisible_by(n, 7), do: str <> "Plong", else: str
    end
  end

  def divisible_by(a, b), do: rem(a, b) == 0
end
