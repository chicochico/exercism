defmodule ISBNVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn = String.replace(isbn, "-", "")
    cond do
      String.match?(isbn, ~r/[^0-9X]/) ->
        false
      true ->
        isbn
        |> String.graphemes()
        |> Enum.map(fn c ->
          case c do
            "X" -> 10
            _ -> String.to_integer(c)
          end
        end)
        |> Enum.zip(Enum.to_list(10..1))
        |> Enum.map(fn {a, b} -> a * b end)
        |> Enum.sum()
        |> rem(11)
        |> Kernel.==(0)
    end
  end
end
