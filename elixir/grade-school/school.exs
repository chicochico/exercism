defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade) do
    db
    |> Map.update(grade, [name], &(&1 ++ [name]))
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
    case Map.get(db, grade) do
      nil -> []
      names -> names
    end
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) do
    for grade <- db, do: {elem(grade, 0), elem(grade, 1) |> Enum.sort}
  end
end
