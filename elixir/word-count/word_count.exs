defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    words =
      Regex.scan(~r/[\p{L}1-9\-]+/u, String.downcase sentence)
      |> List.flatten

    Enum.reduce(words, %{}, &increment(&2, &1))
  end

  def increment(counter, word) when is_map(counter) do
    Map.update(counter, word, 1, &(&1+1))
  end
end
