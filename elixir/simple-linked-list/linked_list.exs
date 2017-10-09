defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    {}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, e) do
    {e, list}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length({}), do: 0
  def length(list), do: length(elem(list, 1), 0)
  def length({}, n), do: n+1
  def length(list, n), do: length(elem(list, 1), n+1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({}), do: true
  def empty?(list) when is_tuple(list), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({}), do: {:error, :empty_list}
  def peek(list), do: {:ok, elem(list, 0)}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({}), do: {:error, :empty_list}
  def tail({_, t}), do: {:ok, t}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({}), do: {:error, :empty_list}
  def pop(list) do
    h = elem(list, 0)
    t = elem(list, 1)
    {:ok, h, t}
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list), do: from_list(list, {})
  def from_list([], acc), do: reverse(acc)
  def from_list([h|t], acc) do
    acc = push(acc, h)
    from_list(t, acc)
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list), do: to_list(list, [])
  def to_list({}, l), do: l
  def to_list(list, l) do
    {:ok, h, t} = pop(list)
    to_list(t, l++[h])
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: reverse(list, {})
  def reverse({}, rev), do: rev
  def reverse(list, rev) do
    {:ok, h, t} = pop(list)
    rev = push(rev, h)
    reverse(t, rev)
  end
end
