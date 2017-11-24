defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, rails) do
    graphemes = String.graphemes(str)
    cond do
      rails > 1 -> stream = Enum.to_list(0..(rails-1)) ++ Enum.to_list((rails-2)..1)
      rails == 1 -> stream = [0]
    end
    bar = Stream.cycle(stream) |> Enum.take(length(graphemes))
    chars = Enum.zip(graphemes, bar)
            |> Enum.group_by(fn {_, i} -> i end)
    for {_, rail} <- chars, {c, _} <- rail do
      c
    end
    |> Enum.join
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, rails) do
    graphemes = String.graphemes(str)
    cond do
      rails > 1 -> stream = Enum.to_list(0..(rails-1)) ++ Enum.to_list((rails-2)..1)
      rails == 1 -> stream = [0]
    end
    bar =
      stream
      |> Stream.cycle
      |> Enum.take(length graphemes)
      |> Enum.zip(0..(length(graphemes)))
      |> Enum.sort
      |> Enum.zip(graphemes)
      |> Enum.sort(fn {{_, a}, _}, {{_, b}, _} -> a < b end)

    (for {{_, _}, c} <- bar, do: c)
    |> Enum.join
  end
end
