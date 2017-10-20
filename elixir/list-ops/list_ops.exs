defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.
  @spec count(list) :: non_neg_integer
  def count(l), do: count(l, 0)
  def count([], counter), do: counter
  def count([_|t], counter), do: count(t, counter+1)

  @spec reverse(list) :: list
  def reverse([]), do: []
  def reverse([h|t]), do: reverse(t, [h])
  def reverse([h|t], acc), do: reverse(t, [h|acc])
  def reverse([], acc), do: acc

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: for e <- l, do: f.(e)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: for e <- l, f.(e), do: e

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h|t], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append(l1, l2), do: reverse(l1) |> do_append(l2)

  defp do_append([], acc), do: acc
  defp do_append([h|t], acc), do: do_append(t, [h|acc])

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([h|t]) when is_list(h), do: concat(t, reverse(h))
  def concat([h|t]), do: concat(t, [h])
  def concat([h|t], acc) when is_list(h), do: concat(append(h, t), acc)
  def concat([h|t], acc), do: concat(t, [h|acc])
  def concat([], acc), do: reverse(acc)
end
