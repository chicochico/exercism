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
    for {row, i} <- Enum.with_index(rows),
      {n, j} <- Enum.with_index(row),
      n >= Enum.max(row) and n <= Enum.min(at(cols, j)),
      do: {i, j}
  end

  @spec at([], integer) :: any
  def at(list, i) do
    list
    |> Enum.at(i)
  end
end
