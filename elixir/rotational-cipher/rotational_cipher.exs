defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) when is_binary(text) do
    text
    |> String.to_charlist
    |> Enum.reduce(<<>>, &shift_char(&1, &2, shift))
    |> to_string
  end

  defp shift_char(char, acc, shift) do
    cond do
      char < 65 ->
        acc <> <<char>>
      char >= 65 and char <= 90 -> # small case
        acc <> <<rem(char-65+shift, 26) + 65>>
      char >= 97  and char <= 122 -> # upcase
        acc <> <<rem(char-97+shift, 26) + 97>>
    end
  end
end

