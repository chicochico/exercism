defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Enum.join()
    |> String.graphemes()
    |> Enum.chunk_every(workers)
    |> Enum.map(&Enum.join(&1))
    |> Enum.map(fn text -> Task.async(fn -> count_frequency(text) end) end)
    |> Enum.map(&Task.await(&1))
    |> join_results()
  end

  def join_results(results) do
    results
    |> Enum.reduce(%{}, &Map.merge(&1, &2, fn _k, v1, v2 -> v1 + v2 end))
  end

  def count_frequency(text) do
    clean =
      ~r/[0-9\s[:punct:]]/u
      |> Regex.replace(text, "")
      |> String.downcase
      |> String.graphemes

    MapSet.new(clean)
    |> Enum.map(fn chr ->
      {chr, Enum.count(clean, &(&1 == chr))}
    end)
    |> Enum.into(%{})
  end
end
