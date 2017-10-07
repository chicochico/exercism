defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """

  @lyrics File.read!("lyrics.txt")
          |> String.split("\n\n")
          |> Enum.map(&(String.replace &1, "\n", ""))

  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    Enum.at(@lyrics, number-1)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Enum.slice(@lyrics, starting_verse-1..ending_verse-1)
    |> Enum.reduce("", &(&2 <> &1 <> "\n"))
    |> String.slice(0..-2)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    Enum.reduce(@lyrics, "", &(&2 <> &1 <> "\n"))
    |> String.slice(0..-2)
  end
end

