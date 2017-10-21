defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    {:ok, first_day} = Date.new(year, month, 1)
    {:ok, last_day} = Date.new(year, month, Date.days_in_month(first_day))

    Date.range(first_day, last_day)
    |> Enum.to_list
    |> get_only_weekday(weekday)
    |> get_correct_date(schedule)
    |> date_to_tuple()
  end

  defp date_to_tuple(%{:year => y, :month => m, :day => d}) do
    {y, m, d}
  end

  defp get_correct_date(possible_dates, schedule) do
    case schedule do
      :first -> possible_dates |> Enum.at(0)
      :second -> possible_dates |> Enum.at(1)
      :third -> possible_dates |> Enum.at(2)
      :fourth -> possible_dates |> Enum.at(3)
      :last -> possible_dates |> Enum.reverse |> Enum.at(0)
      :teenth -> possible_dates |> Enum.find(&(&1.day >= 13 and &1.day <= 19))
    end
  end

  defp get_only_weekday(month, weekday) do
    month
    |> Enum.filter(&(Date.day_of_week(&1) == day_of_week(weekday)))
  end

  defp day_of_week(weekday) do
    case weekday do
      :monday -> 1
      :tuesday -> 2
      :wednesday -> 3
      :thursday -> 4
      :friday -> 5
      :saturday -> 6
      :sunday -> 7
      _ -> :invalid_weekday
    end
  end
end
