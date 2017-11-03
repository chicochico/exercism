defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn row ->
      Enum.map(row, &String.to_integer(&1))
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows
    |> Enum.zip
    |> Enum.map(&Tuple.to_list(&1))
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rows = rows(str)
    cols = columns(str)
    row_max = Enum.map(rows, &Enum.max(&1))
    col_min = Enum.map(cols, &Enum.min(&1))

    get_indexes(row_max, col_min)
    |> List.flatten
    |> Enum.reduce([], fn {i, j}, acc ->
      e = at(rows, i, j)
      if e >= at(row_max, i) and e <= at(col_min, j) do
        acc ++ [{i, j}]
      else
        acc
      end
    end)
  end

  @doc """
  generate tuples with indexes to iterate thru
  a list of lists
  """
  @spec get_indexes(list, list) :: [tuple]
  def get_indexes(l1, l2) do
    for i <- 0..length(l1)-1 do
      for j <- 0..length(l2)-1 do
        {i, j}
      end
    end
  end

  @doc """
  get the element of a matrix given the row and column
  """
  @spec at([list], integer, integer) :: any
  def at(matrix, i, j) do
    matrix
    |> Enum.at(i)
    |> Enum.at(j)
  end

  @spec at([], integer) :: any
  def at(list, i) do
    list
    |> Enum.at(i)
  end

end
