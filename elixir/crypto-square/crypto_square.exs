defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(str) do
    str =
      str
      |> String.downcase
      |> String.replace(" ", "")
      |> String.replace(~r/[[:punct:]]/, "")
      |> String.graphemes

    columns = find_column_count(length str)
    padding = List.duplicate("_", columns)

    str
    |> Enum.chunk_every(columns, columns, padding)
    |> Enum.zip
    |> Enum.map(&Tuple.to_list(&1))
    |> Enum.map(&Enum.join(&1))
    |> Enum.join(" ")
    |> String.replace("_", "")
  end

  @doc """
  Find ideal column count for given length
  """
  @spec find_column_count(integer, integer) :: integer
  def find_column_count(len), do: find_column_count(len, 1)
  def find_column_count(len, n) when n*n >= len, do: n
  def find_column_count(len, n), do: find_column_count(len, n+1)
end
