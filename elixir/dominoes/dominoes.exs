defmodule Dominoes do

  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino] | []) :: boolean
  def chain?([]), do: true
  def chain?([{a, a}]), do: true
  def chain?([{a, b}]), do: false
  def chain?(dominoes) do
    dominoes
    |> zipper()  # create zipper
    |> chain?([])
  end
  def chain?({left, curr, right}=dominoes, []) do
    unused =
      (left ++ right)
      |> zipper()  # unused stones
    unused
    |> chain?([curr])
    |> case do
      true -> true
      false ->  # no chain, try flipping the starting stone
        unused
        |> chain?([flip(curr)])
    end
    |> case do
      true -> true
      false ->  # no chain, try next stone as starting point
        case dominoes do
          {[], _, _} -> false
          _ ->
            dominoes
            |> znext()
            |> chain?([])
        end
    end
  end
  def chain?({[], curr, []}, [prev | _]=path) do
    with {_, _} = position <- connect(prev, curr),  # check if last stone can be chained
         {{a, _}, {_, a}} <- {Enum.at(path, -1), position} do  # check if ends are equal
      true
    else
      _ -> false
    end
  end
  def chain?({[], curr, right}, [prev | _]=path) do
    case connect(prev, curr) do
      {_, _} = position ->
        right
        |> zipper()
        |> chain?([position | path])
      _ -> false
    end
  end
  def chain?({left, curr, right}=dominoes, [prev | _]=path) do
    case connect(prev, curr) do
      {_, _} = position ->
        (left ++ right)
        |> zipper()
        |> chain?([position | path])
      _ ->
        dominoes
        |> znext()
        |> chain?(path)
    end
  end

  @doc """
  create a zipper to go trhu each domino keeping the unused accesible
  """
  @spec zipper([domino]) :: {[domino], domino, [domino]}
  def zipper([h | t]) do
    {t, h, []}
  end
  def znext({[h | t], focus, right}) do
    {t, h, [focus | right]}
  end

  @doc """
  takes two dominoes and try to connect second to first
  if its possible, return the position of the connection
  """
  @spec connect(domino, domino) :: domino | nil
  def connect(d1, d2) do
    case {d1, d2} do
      {{_, a}, {a, _}} -> d2
      {{_, a}, {_, a}} -> flip(d2)
      _ -> nil
    end
  end

  @doc """
  return a domino flipped 180 degrees
  """
  @spec flip(domino) :: domino
  def flip({a, b}), do: {b, a}
end
