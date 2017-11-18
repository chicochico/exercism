defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(operation) do
    operation
    |> parse
    |> calculate
  end

  @spec parse(String.t()) :: [integer | String.t()]
  def parse("What is " <> operation) do
    ~r/-*\d+|(?!by\b)\b\w+/
    |> Regex.scan(operation)
    |> Enum.map(fn [element] ->
      cond do
        Regex.match?(~r/-*\d+/, element) ->
          String.to_integer(element)
        true -> element
      end
    end)
  end

  def parse(_), do: raise ArgumentError

  @spec calculate(list) :: integer | float
  def calculate([result]), do: result
  def calculate([a, "plus", b| t]), do: calculate([a+b|t])
  def calculate([a, "minus", b| t]), do: calculate([a-b|t])
  def calculate([a, "multiplied", b| t]), do: calculate([a*b|t])
  def calculate([a, "divided", b| t]), do: calculate([a/b|t])
  def calculate([a, "cubed"]), do: a*a*a
end
