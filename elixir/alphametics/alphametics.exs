defmodule Alphametics do
  @type puzzle :: binary
  @type solution :: %{required(?A..?Z) => 0..9}

  @doc """
  Takes an alphametics puzzle and returns a solution where every letter
  replaced by its number will make a valid equation. Returns `nil` when
  there is no valid solution to the given puzzle.

  ## Examples

      iex> Alphametics.solve("I + BB == ILL")
      %{?I => 1, ?B => 9, ?L => 0}

      iex> Alphametics.solve("A == B")
      nil
  """
  @spec solve(puzzle) :: solution | nil
  def solve(puzzle) do
    words = get_words(puzzle)
    chars = get_unique_chars(words)
    no_zero = get_no_zero_indexes(words, chars)

    0..9
    |> Enum.to_list
    |> perms(length(chars))
    |> Enum.reject(&leading_zero?(&1, no_zero))
    |> Enum.reduce_while([], fn candidate, acc ->
      solution =
        chars
        |> Enum.zip(candidate)
        |> Map.new

      if valid_solution?(solution, puzzle) do
        {:halt, candidate}
      else
        {:cont, acc}
      end
    end)
    |> case do
      [] -> nil
      solution ->
        chars
        |> Enum.join
        |> to_charlist
        |> Enum.zip(solution)
        |> Map.new
    end
  end

  @spec get_words(String.t) :: [String.t]
  defp get_words(puzzle) do
    ~r/\w+/
    |> Regex.scan(puzzle)
  end

  @spec get_unique_chars([String.t]) :: [String.t]
  defp get_unique_chars(words) do
    words
    |> Enum.join
    |> String.graphemes
    |> MapSet.new
    |> MapSet.to_list
  end

  @spec get_no_zero_indexes([String.t], [String.t]) :: [integer]
  defp get_no_zero_indexes(words, chars) do
    words
    |> List.flatten
    |> Enum.map(&String.slice(&1, 0..0))
    |> Enum.map(&Enum.find_index(chars, fn c -> c == &1 end))
    |> MapSet.new
    |> MapSet.to_list
  end

  @doc """
  return permutations
  """
  @spec perms([any], integer) :: [list]
  def perms(elements), do: perms(elements, length(elements))
  def perms([], _), do: [[]]
  def perms(_,  0), do: [[]]
  def perms(elements, i) do
    for a <- elements, b <- perms(elements -- [a], i-1), do: [a | b]
  end

  @spec valid_solution?(map, String.t) :: boolean
  defp valid_solution?(solution, puzzle) do
    translated =
      solution
      |> Enum.reduce(puzzle, fn {k, v}, acc ->
        acc
        |> String.replace(k, Integer.to_string(v))
      end)

    ~r/\d+/
    |> Regex.scan(translated)
    |> List.flatten
    |> Enum.map(&String.to_integer(&1))
    |> check_equation
  end

  @spec check_equation([integer]) :: boolean
  defp check_equation(eq) do
    [result | addends] = Enum.reverse(eq)

    addends
    |> Enum.reduce(0, fn n, acc -> n + acc end)
    |> Kernel.==(result)
  end

  @spec leading_zero?([integer], [integer]) :: boolean
  defp leading_zero?(elements, indexes) do
    indexes
    |> Enum.any?(fn i -> Enum.at(elements, i) == 0 end)
  end
end
