defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(nil, data) do
    %{data: data, left: nil, right: nil}
  end
  def insert(%{data: node_data} = tree_node, data) do
    cond do
      data <= node_data ->
        %{tree_node | left: insert(tree_node.left, data)}
      data > node_data ->
        %{tree_node | right: insert(tree_node.right, data)}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree), do: in_order([], tree)
  def in_order(acc, nil), do: acc
  def in_order(acc, %{data: data, left: l, right: r}) do
    in_order(acc, l)
    |> Kernel.++([data])
    |> in_order(r)
  end
end
