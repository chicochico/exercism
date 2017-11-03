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

    for i <- 0..length(row_max)-1 do
      for j <- 0..length(col_min)-1 do
        {i, j}
      end
    end
    |> List.flatten
    |> Enum.reduce([], fn {i, j}, acc ->
      e = at(rows, i, j)
      with true <- e >= Enum.at(row_max, i),
           true <- e <= Enum.at(col_min, j) do
        acc ++ [{i, j}]
      else
        false -> acc
      end
    end)
  end

  @doc """
  get the element of a matrix given the row and column
  """
  @spec at([[]], integer, integer) :: any
  def at(matrix, i, j) do
    matrix
    |> Enum.at(i)
    |> Enum.at(j)
  end
end
