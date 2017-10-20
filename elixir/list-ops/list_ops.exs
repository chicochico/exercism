defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.
  @spec count(list) :: non_neg_integer
  def count([_|t]), do: 1 + count(t)
  def count([]), do: 0

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  def reverse([h|t], acc), do: reverse(t, [h|acc])
  def reverse([], acc), do: acc

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: for e <- l, do: f.(e)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: for e <- l, f.(e), do: e

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([h|t], acc, f), do: reduce(t, f.(h, acc), f)
  def reduce([], acc, _), do: acc

  @spec append(list, list) :: list
  def append([h|t], l2), do: [h|append(t, l2)]
  def append([], l2), do: l2

  @spec concat([[any]]) :: [any]
  def concat([h|t]), do: append(h, concat(t))
  def concat([]), do: []
end
