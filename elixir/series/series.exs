defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    upper_limit = String.length(s) - size

    if upper_limit >= 0  and size > 0 do
      for i <- 0..upper_limit, do: String.slice(s, i, size)
    else
      []
    end
  end
end

