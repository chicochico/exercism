defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found
  def search(numbers, key) do
    size = tuple_size(numbers)-1
    search(numbers, key, 0, size)
  end

  @spec search(tuple, integer, integer, integer) :: {:ok, integer} | :not_found
  def search(numbers, key, pos, pos) do
    cond do
      key == elem(numbers, pos) -> {:ok, pos}
      true -> :not_found
    end
  end

  @spec search(tuple, integer, integer, integer) :: {:ok, integer} | :not_found
  def search(numbers, key, left, right) do
    middle = left + floor(right-left, 2)
    element = elem(numbers, middle)
    cond do
      key == element -> {:ok, middle}
      key < element -> search(numbers, key, left, middle-1)
      key > element -> search(numbers, key, middle+1, right)
    end
  end

  @spec floor(integer, integer) :: integer
  def floor(a, b) do
    a/b
    |> :math.floor
    |> round
  end
end
