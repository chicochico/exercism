defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a string representation of a clock:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    to_minutes(hour, minute)
    |> from_minutes_to_clock
  end

  @doc """
  Adds two clock times:

      iex> Clock.add(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    to_minutes(hour, minute + add_minute)
    |> from_minutes_to_clock
  end

  @doc """
  Transform time to minutes
  """
  @spec to_minutes(integer, integer) :: integer
  def to_minutes(hours, minutes) do
    hours = rem(hours, 24)
    total_minutes = (hours * 60) + minutes
    1440 + rem(total_minutes, 1440)
  end

  @doc """
  Return a Clock instance from minutes
  """
  @spec from_minutes_to_clock(integer) :: integer
  def from_minutes_to_clock(minutes) do
    %Clock{
      hour: div(minutes, 60) |> rem(24),
      minute: rem(minutes, 60)
    }
  end
end

defimpl String.Chars, for: Clock do
  def to_string(%Clock{hour: hour, minute: minute}) do
    hour =
      hour
      |> Integer.to_string
      |> String.pad_leading(2, "0")

    minute =
      minute
      |> Integer.to_string
      |> String.pad_leading(2, "0")

    "#{hour}:#{minute}"
  end
end

