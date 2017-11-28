defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]
  def annotate([]), do: []
  def annotate(board) do
    lines = length(board)
    cols = board |> List.first |> String.length
    board = board |> Enum.map(&String.graphemes(&1))

    for i <- 0..(lines-1) do
      for j <- 0..(cols-1) do
        case at(board, {i, j}) do
          " " ->
            lookaround(board, {i, j})
            |> count_mines
            |> case do
              0 -> " "
              n -> Integer.to_string(n)
            end
          foo -> foo
        end
      end
    end
    |> Enum.map(&Enum.join(&1))
  end

  @doc """
  Get the element at row i and column j
  in a bidimensional array
  """
  @spec at([list], {integer, integer}) :: any
  def at(matrix, {i, j}) do
    cond do
      i < 0 or j < 0 -> nil
      true ->
        matrix
        |> Enum.at(i)
        |> case do
          nil -> nil
          l -> Enum.at(l, j)
        end
    end
  end

  @doc """
  Look around the current position in a bidimensional
  array
  """
  @spec lookaround([list], {integer, integer}) :: [any]
  def lookaround(matrix, {i, j}) do
    [
      matrix |> at({i-1, j-1}),
      matrix |> at({i-1, j}),
      matrix |> at({i-1, j+1}),
      matrix |> at({i, j-1}),
      matrix |> at({i, j+1}),
      matrix |> at({i+1, j-1}),
      matrix |> at({i+1, j}),
      matrix |> at({i+1, j+1}),
    ]
  end

  @doc """
  Count the number of mines
  """
  @spec count_mines(list) :: integer
  def count_mines(field) do
    field |> Enum.count(&(&1 == "*"))
  end
end
