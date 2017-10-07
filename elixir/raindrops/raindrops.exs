defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    factors = prime_factors(number)
    conversion = ""
      |> raindrop(factors, :pling)
      |> raindrop(factors, :plang)
      |> raindrop(factors, :plong)

    if conversion == "" do
      Integer.to_string(number)
    else
      conversion
    end
  end

  def raindrop(str, factors, :pling) do
    if 3 in factors, do: str <> "Pling", else: str
  end

  def raindrop(str, factors, :plang) do
    if 5 in factors, do: str <> "Plang", else: str
  end

  def raindrop(str, factors, :plong) do
    if 7 in factors, do: str <> "Plong", else: str
  end

  def is_prime(2), do: true
  def is_prime(3), do: true
  def is_prime(n) do
    upper_limit = :math.sqrt(n) |> :math.floor |> round
    Enum.all?(2..upper_limit, &(rem(n, &1) != 0))
  end

  def prime_factors(1), do: []
  def prime_factors(primes \\ [], n) when is_list(primes) do
    if is_prime(n) do
      primes ++ [n]
    else
      ls = smallest_factor(n)  # left side
      rs = n/ls |> :math.floor |> round  # right side
      prime_factors(primes, ls) |> prime_factors(rs)
    end
  end

  def smallest_factor(n) do
    Enum.find(2..n, &(rem(n, &1) == 0))
  end
end
