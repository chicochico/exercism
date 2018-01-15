defmodule OCRNumbers do

  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t]) :: String.t
  def convert(input) do
    case check_input(input) do
      {:ok, _} ->
        {:ok, chunk_and_recognize(input)}
      error ->
        error
    end
  end

  @spec chunk_and_recognize([String.t]) :: String.t
  def chunk_and_recognize(input) do
    if length(input) == 4 do
      horizontal_chunk(input)
      |> recognize_numbers
    else
      vertical_chunk(input)
      |> Enum.map(&recognize_numbers(&1))
      |> Enum.join(",")
    end
  end

  @spec recognize_numbers([[String.t]]) :: String.t
  def recognize_numbers(chunks) do
    chunks
    |> Enum.reduce("", fn number, acc ->
      acc <> recognize(number)
    end)
  end

  @spec horizontal_chunk([String.t]) :: [[String.t]]
  def horizontal_chunk(input) do
    input
    |> Enum.map(&String.graphemes(&1))
    |> Enum.map(&Enum.chunk_every(&1, 3))
    |> Enum.map(fn row ->
      row
      |> Enum.map(&Enum.join(&1))
    end)
    |> Enum.zip
    |> Enum.map(&Tuple.to_list(&1))
  end

  @spec vertical_chunk([String.t]) :: [[[String.t]]]
  def vertical_chunk(input) do
    input
    |> Enum.chunk_every(4)
    |> Enum.map(&horizontal_chunk(&1))
  end

  @spec recognize([String.t]) :: String.t
  def recognize(number) do
    case number do
      [" _ ", "| |", "|_|", "   "] -> "0"
      ["   ", "  |", "  |", "   "] -> "1"
      [" _ ", " _|", "|_ ", "   "] -> "2"
      [" _ ", " _|", " _|", "   "] -> "3"
      ["   ", "|_|", "  |", "   "] -> "4"
      [" _ ", "|_ ", " _|", "   "] -> "5"
      [" _ ", "|_ ", "|_|", "   "] -> "6"
      [" _ ", "  |", "  |", "   "] -> "7"
      [" _ ", "|_|", "|_|", "   "] -> "8"
      [" _ ", "|_|", " _|", "   "] -> "9"
      _ -> "?"
    end
  end

  @spec check_input([String.t]) :: {atom, String.t}
  defp check_input(input) do
    valid_lines = (input |> length |> rem(4)) == 0
    valid_colums =
      input
      |> Enum.join
      |> String.length
      |> rem(3)
      |> Kernel.==(0)

    cond do
      valid_lines and valid_colums -> {:ok, "valid"}
      !valid_lines -> {:error, 'invalid line count'}
      !valid_colums -> {:error, 'invalid column count'}
    end
  end
end
