defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  use Bitwise

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    [1, 2, 4, 8]
    |> Enum.reduce([], fn c, acc -> acc ++ get_action(c &&& code) end)
    |> reverse_if_needed(16 &&& code)
  end

  defp get_action(1), do: ["wink"]
  defp get_action(2), do: ["double blink"]
  defp get_action(4), do: ["close your eyes"]
  defp get_action(8), do: ["jump"]
  defp get_action(_), do: []
  defp reverse_if_needed(list, code) do
    case code do
      16 -> Enum.reverse(list)
      _ -> list
    end
  end
end

