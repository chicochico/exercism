defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter) do
    diamond =
      letter
      |> build_top
      |> build_bottom

    diamond
    |> Enum.map(fn charlist ->
      charlist
      |> List.to_string
      |> pad(length(diamond))
    end)
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  @spec build_top(integer) :: list
  def build_top(letter) do
    Enum.to_list(?A..letter)
    |> get_spaces_count
    |> Enum.map(fn {char, spaces} ->
      case spaces do
        0 -> [char]
        _ -> [char] ++ List.duplicate(?\s, spaces) ++ [char]
      end
    end)
  end

  @spec build_bottom(list) :: list
  def build_bottom(top) do
    bottom =
      top
      |> Enum.reverse
      |> tl
    top ++ bottom
  end

  @spec pad(String.t(), integer) :: String.t()
  def pad(str, width) do
    str_length = String.length(str)
    pad_size = (width - str_length)/2 |> round

    str
    |> String.pad_leading(pad_size + str_length)
    |> String.pad_trailing(width)
  end

  @spec get_spaces_count(charlist) :: [tuple]
  def get_spaces_count(charlist) do
    cond do
      length(charlist) == 1 ->
        Enum.zip(charlist, [0])
      length(charlist) == 2 ->
        Enum.zip(charlist, [0, 1])
      true ->
        charlist
        |> Enum.zip([0, 1] ++ Enum.scan(1..length(charlist)-2, 1, fn _, last -> last+2 end))
    end
  end
end
