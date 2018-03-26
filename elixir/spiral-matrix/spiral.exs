defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []
  def matrix(size) do
    size
    |> square_matrix()
    |> unroll()
    |> Enum.zip(1..size*size)
    |> Enum.sort(fn {a, _}, {b, _} -> a < b end)
    |> Enum.map(fn {_, a} -> a end)
    |> Enum.chunk_every(size)
  end

  @doc """
  unroll a matrix like a tape counterclockwise
  """
  @spec unroll([list], [list]) :: list
  def unroll(array, acc \\ [])
  def unroll([], acc) do
    acc
    |> Enum.reverse()
    |> List.flatten
  end
  def unroll(array, acc) do
    [top | rest] = array
    rest
    |> transpose()
    |> unroll([top | acc])
  end

  @doc """
  generate a square matrix with integers 1 to size^2
  """
  @spec square_matrix(integer) :: [list]
  def square_matrix(size) do
    1..size*size
    |> Enum.chunk_every(size)
  end

  @spec transpose([list]) :: [list]
  def transpose(array) do
    array
    |> Enum.zip()
    |> Enum.reverse()
    |> Enum.map(&Tuple.to_list(&1))
  end
end
