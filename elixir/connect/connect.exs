defmodule Connect do
  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t]) :: :none | :black | :white
  def result_for(board) do
    cond do
      player_connected?("O", board) -> :white
      player_connected?("X", board) -> :black
      true -> :none
    end
  end

  @doc """
  Will check if player connected top and bottom
  """
  @spec player_connected?(String.t(), list) :: boolean
  def player_connected?(player, board) do
    board =
      case player do
        "O" ->
          board
          |> Enum.map(&String.graphemes(&1))
          |> with_index
        "X" ->
          board
          |> Enum.map(&String.graphemes(&1))
          |> transpose
          |> with_index
      end

    board
    |> get_starting_point
    |> Enum.filter(fn {side, _} -> side == player end)
    |> explore([], board)
    |> Enum.any?(fn {_, {row, _}} -> row == 0 end)
  end

  @spec get_starting_point([list]) :: list
  defp get_starting_point(board) do
    board
    |> List.last
  end

  @spec transpose([list]) :: [list]
  defp transpose(board) do
    board
    |> Enum.zip
    |> Enum.map(&Tuple.to_list(&1))
  end

  @doc """
  Given a starting point will explore
  all possible paths
  """
  @spec explore(list, list, [list]) :: list
  def explore([], visited, _board), do: visited

  def explore([h|t], visited, board) do
    h
    |> find_next_steps(visited, board)
    |> case do
      [] -> explore(t, [h|visited], board)
      neighbors -> explore(neighbors ++ t, [h|visited], board)
    end
  end

  @doc """
  Look at the adjacent neighbors
  and returns the reachable next nodes
  """
  @spec find_next_steps({String.t(), tuple}, list, [list]) :: list
  def find_next_steps({color, {i, j}}, visited, board) do
    lookaround(board, i, j)
    |> Enum.filter(fn {player, _} -> player == color end)
    |> Enum.reject(fn pos -> pos in visited end)
  end

  @doc """
  Add indexes for each element in the board
  """
  @spec with_index([list]) :: [list]
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

