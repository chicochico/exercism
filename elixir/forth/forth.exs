defmodule Forth do
  @opaque evaluator :: any

  @default_words %{"+" => "+",
                   "-" => "-",
                   "*" => "*",
                   "/" => "/",
                   "dup" => "dup",
                   "drop" => "drop",
                   "swap" => "swap",
                   "over" => "over"}

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    %{:stack => [], :words => @default_words}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t) :: evaluator
  def eval(ev, s) do
    {ev, s} =
      s
      |> String.downcase
      |> make_redefinitions(ev)

    s = replace_redefinitions(ev, s)

    ~r/-?\d+|[a-zA-Z]+|\+|\*|\/|&|(?<=\s)-/
    |> Regex.scan(s)
    |> Enum.map(fn [symbol] -> symbol end)
    |> Enum.reduce(ev, &push_symbol(&1, &2))
  end

  @spec push_symbol(String.t, evaluator) :: evaluator | Forth.UnknownWord
  defp push_symbol(symbol, ev) do
    cond do
      String.match?(symbol, ~r/^-?\d+$/) ->
        %{ev | :stack => [String.to_integer(symbol) | ev.stack]}
      symbol in ~w(+ - * / dup drop swap over) ->
        %{ev | :stack => do_operation(symbol, ev.stack)}
      true ->
        raise Forth.UnknownWord
    end
  end

  @spec do_operation(String.t, list) :: list | Forth.DivisionByZero | Forth.StackUnderflow
  defp do_operation(operation, stack) do
    stack_size = length(stack)
    case operation do
      "+" when stack_size >= 2 ->
        [a, b | t] = stack
        [b + a | t]
      "-" when stack_size >= 2 ->
        [a, b | t] = stack
        [b - a | t]
      "*" when stack_size >= 2 ->
        [a, b | t] = stack
        [b * a | t]
      "/" when stack_size >= 2 ->
        [a, b | t] = stack
        case a do
          0 -> raise Forth.DivisionByZero
          _ -> [:math.floor(b/a) |> round | t]
        end
      "dup" when stack_size >= 1 ->
        [a | _] = stack
        [a | stack]
      "drop" when stack_size >= 1 ->
        [_ | t] = stack
        t
      "swap" when stack_size >= 2 ->
        [a, b | t] = stack
        [b, a | t]
      "over" when stack_size >= 2 ->
        [a, b | t] = stack
        [b, a, b | t]
      _ -> raise Forth.StackUnderflow
    end
  end

  @spec make_redefinitions(String.t, evaluator) :: {evaluator, String.t}
  def make_redefinitions(s, ev) do
    redefinitions = Regex.scan(~r/: .+ ;/, s)

    ev =
      redefinitions
      |> Enum.map(fn [symbol] -> symbol end)
      |> Enum.reduce(ev, &redefine_word(&1, &2))

    s =
      redefinitions
      |> Enum.reduce(s, &String.replace(&2, &1, ""))

    {ev, s}
  end

  @spec redefine_word(String.t, evaluator) :: evaluator | Forth.InvalidWord
  def redefine_word(redefinition, ev) do
    if String.match?(redefinition, ~r/^: [^\d\n]+ [^\n]+ ;$/) do
      [word | definition] =
        redefinition
        |> String.split()
        |> Enum.slice(1..-2)

      redefined = Map.put(ev.words, word, Enum.join(definition, " "))
      %{ev | :words => redefined}
    else
      raise Forth.InvalidWord
    end
  end

  @spec replace_redefinitions(evaluator, String.t) :: String.t
  def replace_redefinitions(ev, s) do
    ev.words
    |> Map.keys
    |> Enum.reduce(s, &String.replace(&2, &1, ev.words[&1]))
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t
  def format_stack(ev) do
    ev.stack
    |> Enum.reverse
    |> Enum.join(" ")
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception [word: nil]
    def message(e), do: "invalid word: #{inspect e.word}"
  end

  defmodule UnknownWord do
    defexception [word: nil]
    def message(e), do: "unknown word: #{inspect e.word}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
