defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @default_students [
   :alice,
   :bob,
   :charlie,
   :david,
   :eve,
   :fred ,
   :ginny,
   :harriet,
   :ileana ,
   :joseph ,
   :kincaid,
   :larry
  ]

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_students) do
    info_string
    |> parse_info_string()
    |> pad_no_plants(length(student_names))
    |> assemble_result(student_names)
  end

  defp assemble_result(garden, student_names) do
    student_names
    |> Enum.sort
    |> Enum.zip(garden)
    |> Map.new
  end

  defp pad_no_plants(garden, padding) do
    1..length(garden)-padding
    |> Enum.reduce(garden, fn _, acc ->  acc ++ [{}] end)
  end

  defp parse_info_string(info_string) do
    info_string
    |> String.split("\n")
    |> Enum.map(&to_charlist(&1))
    |> Enum.map(&Enum.chunk_every(&1, 2))
    |> Enum.zip
    |> Enum.map(fn {front_row, back_row} -> front_row ++ back_row end)
    |> Enum.map(&get_student_plants(&1))
  end

  defp get_student_plants(plants) do
    plants
    |> Enum.reduce({}, &Tuple.append(&2, plant(&1)))
  end

  defp plant(p) do
    case p do
      ?G -> :grass
      ?C -> :clover
      ?R -> :radishes
      ?V -> :violets
    end
  end
end
