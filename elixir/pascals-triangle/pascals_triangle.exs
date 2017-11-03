defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    for n <- 0..num-1, do: generate_row(n)
  end

  defp generate_row(0), do: [1]
  defp generate_row(n) do
    row =
      n..1
      |> Enum.scan(1, &round(&2*(&1/(n-&1+1))))

    [1|row]
  end
end
