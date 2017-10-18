defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0, do: {:error, "all side lengths must be positive"}
  def kind(a, b, c) do
    if is_triangle?(a, b, c) do
      case {a, b, c} do
        {x, y, z} when x+y==z or x+z==y or y+z==x -> {:ok, :degenerate}
        {x, x, x} -> {:ok, :equilateral}
        {x, x, _} -> {:ok, :isosceles}
        {x, _, x} -> {:ok, :isosceles}
        {_, x, x} -> {:ok, :isosceles}
        {_, _, _} -> {:ok, :scalene}
      end
    else
      {:error, "side lengths violate triangle inequality"}
    end
  end

  def is_triangle?(a, b, c) do
    [a, b, c] = [a, b, c] |> Enum.sort
    if a+b >= c do
      true
    else
      false
    end
  end
end
