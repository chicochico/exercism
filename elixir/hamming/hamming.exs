defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2) do
    {:error, "Lists must be the same length"}
  end
  def hamming_distance(strand1, strand1), do: {:ok, 0}
  def hamming_distance(strand1, strand2), do: hamming_distance(strand1, strand2, 0)
  def hamming_distance([], [], acc), do: {:ok, acc}
  def hamming_distance([hs1|ts1], [hs1|ts2], acc), do: hamming_distance(ts1, ts2, acc)
  def hamming_distance([_|ts1], [_|ts2], acc), do: hamming_distance(ts1, ts2, acc+1)
end
