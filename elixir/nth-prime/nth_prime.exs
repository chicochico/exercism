defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count <= 0, do: raise "positive integer is expected"
  def nth(count), do: nth(count, 2)
  def nth(0, prime), do: prime-1
  def nth(count, prime) do
    if is_prime(prime) do
      nth(count-1, prime+1)
    else
      nth(count, prime+1)
    end
  end

  def is_prime(2), do: true
  def is_prime(3), do: true
  def is_prime(n) do
    upper_limit = :math.sqrt(n) |> :math.floor |> round
    Enum.all?(2..upper_limit, &(rem(n, &1) != 0))
  end
end
