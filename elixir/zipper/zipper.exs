defmodule BinTree do
  import Inspect.Algebra
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil

  @type trail :: [ { :left, any, BinTree.t } | { :right, any, BinTree.t } ]

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BT[value: 3, left: BT[value: 5, right: BT[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: v, left: l, right: r}, opts) do
    concat ["(", to_doc(v, opts),
            ":", (if l, do: to_doc(l, opts), else: ""),
            ":", (if r, do: to_doc(r, opts), else: ""),
            ")"]
  end
end

defmodule Zipper do
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t) :: Z.t
  def from_tree(bt) do
    %{
      trail: [],
      focus: {:root, bt}
    }
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree(z) do
    case z.focus do
      {:root, tree} -> tree
      {_, tree_node} -> z |> up |> to_tree
    end
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value(%{focus: {_, tree_node}}) do
    tree_node.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t) :: Z.t | nil
  def left(%{focus: {_, tree_node}} = z) do
    case tree_node.left do
      nil -> nil
      _ ->
        z
        |> Map.update!(:trail, fn trail -> [z.focus|trail] end)
        |> Map.put(:focus, {:left, tree_node.left})
    end
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def right(%{focus: {_, tree_node}} = z) do
    case tree_node.right do
      nil -> nil
      _ ->
        z
        |> Map.update!(:trail, fn trail -> [z.focus|trail] end)
        |> Map.put(:focus, {:right, tree_node.right})
    end
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t
  def up(%{focus: focus} = z) do
    case z.trail do
      [] -> nil
      [h|t] ->
        case focus do
          {:left, tree_node} ->
            z
            |> Map.put(:focus, h)
            |> Map.put(:trail, t)
            |> set_left(tree_node)
          {:right, tree_node} ->
            z
            |> Map.put(:focus, h)
            |> Map.put(:trail, t)
            |> set_right(tree_node)
        end
    end
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value(z, v) do
    z
    |> Map.update!(:focus, fn {dir, tree_node} ->
      {dir, Map.put(tree_node, :value, v)}
    end)
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left(z, l) do
    z
    |> Map.update!(:focus, fn {dir, tree_node} ->
      {dir, Map.put(tree_node, :left, l)}
    end)
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right(z, r) do
    z
    |> Map.update!(:focus, fn {dir, tree_node} ->
      {dir, Map.put(tree_node, :right, r)}
    end)
  end
end

