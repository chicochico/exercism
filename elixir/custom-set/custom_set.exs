defmodule CustomSet do
  defstruct [items: MapSet.new()]
  @opaque t :: %__MODULE__{items: MapSet}


  @spec new(Enum.t) :: t
  def new(enumerable) do
    %CustomSet{items: MapSet.new(enumerable)}
  end

  @spec empty?(t) :: boolean
  def empty?(%CustomSet{items: items}) do
    MapSet.size(items) == 0
  end

  @spec contains?(t, any) :: boolean
  def contains?(%CustomSet{items: items}, element) do
    MapSet.member?(items, element)
  end

  @spec subset?(t, t) :: boolean
  def subset?(%CustomSet{items: items1}, %CustomSet{items: items2}) do
    MapSet.subset?(items1, items2)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%CustomSet{items: items1}, %CustomSet{items: items2}) do
    MapSet.disjoint?(items1, items2)
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    custom_set_1 == custom_set_2
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    Map.update!(custom_set, :items, fn items -> MapSet.put(items, element) end)
  end

  @spec intersection(t, t) :: t
  def intersection(%CustomSet{items: items1}, %CustomSet{items: items2}) do
    %CustomSet{items: MapSet.intersection(items1, items2)}
  end

  @spec difference(t, t) :: t
  def difference(%CustomSet{items: items1}, %CustomSet{items: items2}) do
    %CustomSet{items: MapSet.difference(items1, items2)}
  end

  @spec union(t, t) :: t
  def union(%CustomSet{items: items1}, %CustomSet{items: items2}) do
    %CustomSet{items: MapSet.union(items1, items2)}
  end
end
