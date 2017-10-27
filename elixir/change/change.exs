defmodule Change do
  use Bitwise, only_operators: true

  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t}
  def generate(_, 0), do: {:ok, []}
  def generate(_, target) when target < 0, do: {:error, "cannot change"}
  def generate([smallest_coin|_], target) when smallest_coin > target, do: {:error, "cannot change"}
  def generate(coins, target) do
    gen_accumulator(target)
    |> make_change(coins)
  end

  def make_change(memo, coins) do
    1..Map.size(memo)-1
    |> Enum.reduce(memo, fn i, acc ->
      coins
      |> Enum.filter(&(&1 <= i))
      |> make_change(acc, i)
    end)
    |> fetch_coins()
  end

  def make_change(coins, memo, index) do
    possible_vals =
      (for coin <- coins, do: index - coin)
      |> Enum.reduce([], &(&2 ++ [memo[&1]]))
      |> Enum.reduce([], fn [h|_], acc -> acc ++ [h+1] end)

    count = Enum.min(possible_vals)
    used_coin = Enum.at(coins, Enum.find_index(possible_vals, &(&1 == count)))

    memo
    |> Map.put(index, [count, used_coin])
  end

  def fetch_coins(memo) do
    memo
    |> Enum.sort()
    |> Enum.map(fn {_, [_, coin]} -> coin end)
    |> Enum.reverse()
    |> fetch_coins(0, [])
  end

  def fetch_coins(coins, i, acc) do
    coin = Enum.at(coins, i)
    if coin != 0 do
      fetch_coins(coins, i+coin, acc ++ [coin])
    else
      {:ok, acc}
    end
  end

  def gen_accumulator(target) do
    (for i <- 0..target, do: {i, [nil, nil]})
    |> Enum.into(%{})
    |> Map.put(0, [0, 0])
  end
end

