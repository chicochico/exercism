defmodule Connect do
  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t]) :: :none | :black | :white
  def result_for(board) do
    board =
      board
      |> Enum.map(&String.graphemes(&1))

    white_board = with_index(board)
    black_board =
      board
      |> Enum.zip
      |> Enum.map(&Tuple.to_list(&1))
      |> with_index

    white =
      white_board
      |> List.last
      |> Enum.filter(fn {player, _} -> player == "O" end)
      |> explore([], white_board)
      |> connected?

    black =
      black_board
      |> List.last
      |> Enum.filter(fn {player, _} -> player == "X" end)
      |> explore([], black_board)
      |> connected?

    cond do
      white -> :white
      black -> :black
      true -> :none
    end
  end

  def explore([], visited, _board), do: visited

  def explore([h|t], visited, board) do
    h
    |> find_next_steps(visited, board)
    |> case do
      [] -> explore(t, [h|visited], board)
      neighbors -> explore(neighbors ++ t, [h|visited], board)
    end
  end

  def connected?(visited) do
    visited
    |> Enum.any?(fn {_, {row, _}} -> row == 0 end)
  end

  def find_next_steps({color, {i, j}}, visited, board) do
    lookaround(board, i, j)
    |> Enum.filter(fn {player, _} -> player == color end)
    |> Enum.reject(fn pos -> pos in visited end)
  end

  def with_index(board) do
    rows =  length(board)
    cols =
      board
      |> List.first
      |> length

    for i <- 0..rows-1 do
      for j <- 0..cols-1 do
        {at(board, i, j), {i, j}}
      end
    end
  end

  @doc """
  Get the value at row i and column j
  """
  @spec at([list], integer, integer) :: any
  def at(board, i, j) do
    cond do
      i < 0 or j < 0 -> nil
      true ->
        board
        |> Enum.at(i)
        |> case do
          nil -> nil
          l -> Enum.at(l, j)
        end
    end
  end

  @doc """
  Lookaround six sides of the hexagon
  and get the value of the neighbors
  """
  @spec lookaround([list], integer, integer) :: [any]
  def lookaround(board, i, j) do
    [
      board |> at(i-1, j),    # top left
      board |> at(i-1, j+1),  # top right
      board |> at(i, j-1),    # left
      board |> at(i, j+1),    # right
      board |> at(i+1, j-1),  # bottom left
      board |> at(i+1, j),    # bottom right
    ]
    |> Enum.reject(&(&1 == nil))
  end
end

