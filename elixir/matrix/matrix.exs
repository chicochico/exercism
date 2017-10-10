defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "\s"))
    |> int_elements
  end

  @doc """
  Go thru each element of a string matrix, and convert to integers
  """
  defp int_elements(rows) do
    for row <- rows do
      for e <- row do
        String.to_integer(e)
      end
    end
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    rows = matrix |> str_elements

    for row <- rows do
      Enum.join(row, " ")
    end
    |> Enum.join("\n")
  end

  @doc """
  Go thru each element of a integer matrix and transform to string
  """
  defp str_elements(matrix) do
    for row <- matrix do
      for e <- row do
        Integer.to_string(e)
      end
    end
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix), do: matrix

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    {row, _} = matrix |> List.pop_at(index)
    row
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    matrix
    |> List.zip
    |> Enum.map(&Tuple.to_list(&1))
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    {column, _} =
      matrix
      |> columns
      |> List.pop_at(index)
    column
  end
end

