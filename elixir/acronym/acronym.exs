defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    words =
      Regex.scan(~r/[A-Z][a-z]+|\w+/, string)
      |> List.flatten

    letters = for word <- words, do: String.capitalize(word) |> String.first
    Enum.join(letters)
  end
end
