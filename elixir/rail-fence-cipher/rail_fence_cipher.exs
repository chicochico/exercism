defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, rails) do
    graphemes = String.graphemes(str)
    stream = create_stream(rails, length graphemes)
    encoded =
      graphemes
      |> Enum.zip(stream)
      |> Enum.group_by(fn {_, i} -> i end)

    # extract characters from rails
    (for {_, rail} <- encoded, {c, _} <- rail, do: c)
    |> Enum.join
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, rails) do
    graphemes = String.graphemes(str)
    stream = create_stream(rails, length graphemes)
    decoded =
      stream
      |> Enum.zip(0..(length(graphemes)))
      |> Enum.sort
      |> Enum.zip(graphemes)
      |> Enum.sort(fn {{_, a}, _}, {{_, b}, _} -> a < b end)

    (for {{_, _}, c} <- decoded, do: c)
    |> Enum.join
  end

  @doc """
  Create a stream with the sequence the characters should be written
  """
  @spec create_stream(integer, integer) :: list
  defp create_stream(rails, len) do
    case rails > 1 do
      true -> Enum.to_list(0..(rails-1)) ++ Enum.to_list((rails-2)..1)
      false -> [0]
    end
    |> Stream.cycle
    |> Enum.take(len)
  end
end
