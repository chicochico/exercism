defmodule Change do
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
  def generate(coins, target) do
    cond do
      target == 0 -> {:ok, []}
      target < 0 -> {:error, "cannot change"}
      hd(coins) > target -> {:error, "cannot change"}
      true ->
        # the cache store intermediate results
        generate_cache(target)
        |> make_change(coins)
    end
  end

  @doc """
  Reduce on the cache storing intermediate results, the cache is a map,
  with the key representing the index, and the value the intermediate results
  """
  @spec make_change(map, list) :: {:ok, list} | {:error, String.t}
  def make_change(cache, coins) do
    1..Map.size(cache)-1
    |> Enum.reduce(cache, fn i, acc ->  # go thru each index in the cache
      coins
      |> Enum.filter(&(&1 <= i))  # remove coins that have value bigger than the index
      |> make_change(acc, i)
    end)
    |> fetch_coins()
  end

  @doc """
  Match a empty coins list, and do nothing
  """
  @spec make_change(list, map, any) :: map
  def make_change([], cache, _), do: cache

  @doc """
  Update the cache at index, with current iteration results
  """
  @spec make_change(list, map, integer) :: map
  def make_change(coins, cache, index) do
    possible_vals =
      (for coin <- coins, do: index - coin)
      |> Enum.reduce([], &(&2 ++ [cache[&1]]))
      |> Enum.reduce([], fn [h|_], acc ->
        case h do
          nil -> acc ++ [h]
          _ -> acc ++ [h+1]
        end
      end)

    count = Enum.min(possible_vals)
    used_coin = Enum.at(coins, Enum.find_index(possible_vals, &(&1 == count)))

    cache
    |> Map.put(index, [count, used_coin])
  end

  @doc """
  Fetch the coins that sum up to the change from cached results
  """
  @spec fetch_coins(map) :: list
  def fetch_coins(cache) do
    cache
    |> Enum.sort()
    |> Enum.map(fn {_, [_, coin]} -> coin end)
    |> Enum.reverse()
    |> fetch_coins(0, [])
  end

  @spec fetch_coins(list, integer, list) :: {:ok, list} | {:error, String.t}
  def fetch_coins(coins, i, acc) do
    coin = Enum.at(coins, i)
    cond do
      coin == nil -> {:error, "cannot change"}
      coin == 0 -> {:ok, acc}
      true -> fetch_coins(coins, i+coin, acc ++ [coin])
    end
  end

  @doc """
  Generate a map that is used to store intermediate results,
  %{0 => [0, 0], 1 => [nil, nil], 2 => [nil, nil]...}
  the key is the index, and also a partial sum i.e. what coins sum up to that change,
  the first element in the value is how many coins where used,
  the second is the coin value that was used,
  the first element of the cache is initialized with [0, 0]
  it is a indicator to stop iteration when collecting the coins (see fetch_coins/3)
  """
  @spec generate_cache(integer) :: map
  def generate_cache(target) do
    (for i <- 0..target, do: {i, [nil, nil]})
    |> Enum.into(%{})
    |> Map.put(0, [0, 0])
  end
end

