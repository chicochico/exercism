defmodule Bowling do

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @spec start() :: any
  def start do
    []
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  @spec roll(any, integer) :: any | String.t
  def roll(_game, roll) when roll < 0 do
    {:error, "Negative roll is invalid"}
  end
  def roll(_game, roll) when roll > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end
  def roll([{b1, b2} | _] = game, _roll) when length(game) == 10 and b1+b2 < 10 do
    {:error, "Cannot roll after game is over"}
  end
  def roll([] = game, roll), do: [{roll} | game]
  def roll([{10} | _] = game, roll), do: [{roll} | game]
  def roll([{b1} | t], roll) do
    cond do
      b1+roll > 10 -> {:error, "Pin count exceeds pins on the lane"}
      true -> [{b1, roll} | t]
    end
  end
  def roll([{_, _} | _] = game, roll), do: [{roll} | game]

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(any) :: integer | String.t
  def score(game) do
    {game, bonus} =
      game
      |> Enum.reverse
      |> Enum.split(10)

    case game_is_complete?(game, bonus) do
      true ->
        case bonus do
          [] -> score(game, 0)
          [{b}] -> score(game, b)
          [{b1, b2}] -> score(game, b1+b2)
          [{10}, {b}] -> score(game, 10+b)
        end
      false -> {:error, "Score cannot be taken until the end of the game"}
    end
  end
  def score([], tally), do: tally
  def score([{b1, b2} | t], tally) do
    frame = b1+b2
    cond do
      frame == 10 ->
        case t do
          [{b, _} | _] -> score(t, tally+frame+b)
          [{b} | _] -> score(t, tally+frame+b)
          [] -> score(t, tally+frame)
        end
      true -> score(t, tally+frame)
    end
  end
  def score([{10} | t], tally) do
    case t do
      [{b1, b2} | _] -> score(t, tally+10+b1+b2)
      [{b1}, {b2} | _] -> score(t, tally+10+b1+b2)
      [{b1}, {b2, _} | _] -> score(t, tally+10+b1+b2)
      [{b}] -> score(t, tally+20+b)
      [] -> score(t, tally+10)
    end
  end

  @spec game_is_complete?([tuple], [tuple]) :: boolean
  def game_is_complete?(game, bonus) do
    last_frame = List.last(game)
    if length(game) == 10 do
      case last_frame do
        {10} ->
          case bonus do
            [{10}, {_}] -> true
            [{_, _}] -> true
            _ -> false
          end
        {b1, b2} when b1+b2 == 10 ->
          case bonus do
            [{_}] -> true
            _ -> false
          end
        _ -> true
      end
    else
      false
    end
  end
end
