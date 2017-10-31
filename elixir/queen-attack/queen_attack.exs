defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new({i, j}, {i, j}), do: raise ArgumentError
  def new(white \\ {0, 3}, black \\ {7, 3}) do
    %{:white => white, :black => black}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(%{:white => {wi, wj}, :black => {bi, bj}}) do
    row = ~w(_ _ _ _ _ _ _ _)
    white_row = List.replace_at(row, wj, "W")
    black_row = List.replace_at(row, bj, "B")

    for i <- 0..7 do
      for j <- 0..7 do
        "_"
      end
    end
    |> List.replace_at(wi, white_row)
    |> List.replace_at(bi, black_row)
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%{:white => {wi, wj}, :black => {bi, bj}}) do
    cond do
      wi == bi -> true  # same row
      wj == bj -> true  # same column
      abs(wi-bi) == abs(wj-bj) -> true  # diagonal
      true -> false
    end
  end
end
