defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    brackets = str |> String.graphemes
    {brackets, stack} = Enum.reduce_while(brackets, {brackets, []}, &push_or_pop(&1, &2))

    brackets == stack
  end

  defp push_or_pop(bracket, acc) do
    cond do
      open?(bracket) ->
        {:ok, stack} = push(elem(acc, 1), bracket)
        {:ok, _, brackets} = pop(elem(acc, 0))
        {:cont, {brackets, stack}}
      close?(bracket) ->
        with {:ok, open_bracket, stack} <- pop(elem(acc, 1)),
             {:ok, _, brackets} <- pop(elem(acc, 0)),
             true <- brackets_match?(open_bracket, bracket) do
          {:cont, {brackets, stack}}
        else
          false -> {:halt, acc}
          {:error, _} -> {:halt, acc}
        end
      true ->
        {:ok, _, brackets} = pop(elem(acc, 0))
        {:cont, {brackets, elem(acc, 1)}}
    end
  end

  defp open?(bracket) do
    bracket in ["(", "{", "[", "<"]
  end

  defp close?(bracket) do
    bracket in [")", "}", "]", ">"]
  end

  defp brackets_match?(open, close) do
    open == open_bracket(close)
  end

  defp open_bracket(bracket) do
    case bracket do
      ")" -> "("
      "}" -> "{"
      "]" -> "["
      ">" -> "<"
    end
  end

  defp push(stack, item), do: {:ok, [item] ++ stack}

  defp pop([]), do: {:error, :empty_stack}
  defp pop([h|t]), do: {:ok, h, t}
end

