defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []
end

defmodule Dot do
  defmacro __using__(_options) do
    quote do
      import Dot
    end
  end

  defmacro graph(ast) do
    build_graph(ast)
  end

  defp build_graph(do: ast) do
    %Graph{}
    |> Macro.escape
    |> build_graph(ast)
    |> order_attributes
  end

  defp build_graph(graph, []) do
    graph
  end

  defp build_graph(graph, {:__block__, _, block}) do
    graph
    |> build_graph(block)
  end

  defp build_graph(graph, [h | t]) do
    graph
    |> build_graph(t)
    |> build_graph(h)
  end

  defp build_graph(graph, nil) do
    graph
  end

  defp build_graph(graph, {:graph, _, [attrs]}) do
    graph
    |> update_graph(attrs, :attrs)
  end

  defp build_graph(graph, {:--, _, attrs}) do
    edge = case attrs do
      [{left, _, _}, {right, _, nil}] ->
        {left, right, []}
      [{left, _, _}, {right, _, [attrs]}] ->
        {left, right, attrs}
      _ -> raise ArgumentError
    end
    graph
    |> update_graph(Macro.escape(edge), :edges)
  end

  defp build_graph(graph, {gnode, _, attrs}) do
    gnode = case attrs do
      nil -> {gnode, []}
      [attrs] when is_list(attrs) ->
        if Keyword.keyword?(attrs) do
          {gnode, attrs}
        else
          raise ArgumentError
        end
      _ -> raise ArgumentError
    end
    graph
    |> update_graph(gnode, :nodes)
  end

  defp build_graph(_graph, _invalid) do
    raise ArgumentError
  end

  defp update_graph(graph, new_attrs, attribute) do
    old_data = elem(graph, 2)
    new_data = case attribute do
      :attrs -> List.update_at(old_data, 1, fn {_, contents} ->
        {:attrs, contents ++ new_attrs}
      end)
      :edges -> List.update_at(old_data, 2, fn {_, contents} ->
        {:edges, contents ++ [new_attrs]}
      end)
      :nodes -> List.update_at(old_data, 3, fn {_, contents} ->
        {:nodes, contents ++ [new_attrs]}
      end)
    end
    graph
    |> put_elem(2, new_data)
  end

  defp order_attributes(graph) do
    updated_data =
      elem(graph, 2)
      |> List.update_at(1, fn {_, attrs} -> {:attrs, Enum.sort(attrs)} end)
      |> List.update_at(2, fn {_, attrs} -> {:edges, Enum.sort(attrs)} end)
      |> List.update_at(3, fn {_, attrs} -> {:nodes, Enum.sort(attrs)} end)
    graph
    |> put_elem(2, updated_data)
  end
end
