defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    directions = [:north, :east, :south, :west]
    case position do
      {x, y} when is_integer(x) and is_integer(y) ->
        if direction in directions do
          %{direction: direction, position: position}
        else
          {:error, "invalid direction"}
        end
      _ -> {:error, "invalid position"}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions) do
    robot
    |> move(to_charlist instructions)
  end

  @spec move(robot :: any, instructions :: charlist) :: any
  def move(robot, []), do: robot
  def move(robot, [h|t]) do
    case h do
      ?R -> turn_clockwise(robot) |> move(t)
      ?L -> turn_anticlockwise(robot) |> move(t)
      ?A -> move_forward(robot) |> move(t)
      _ -> {:error, "invalid instruction"}
    end
  end

  @spec turn_clockwise(robot :: any) :: any
  def turn_clockwise(%{direction: direction, position: position}) do
    directions = [:north, :east, :south, :west]
    current = Enum.find_index(directions, &(&1 == direction))
    {:ok, new_direction} =
      directions
      |> Stream.cycle
      |> Enum.fetch(current+1)
    create(new_direction, position)
  end

  @spec turn_anticlockwise(robot :: any) :: any
  def turn_anticlockwise(%{direction: direction, position: position}) do
    directions = [:north, :west, :south, :east]
    current = Enum.find_index(directions, &(&1 == direction))
    {:ok, new_direction} =
      directions
      |> Stream.cycle
      |> Enum.fetch(current+1)
    create(new_direction, position)
  end

  @spec move_forward(robot :: any) :: any
  def move_forward(robot) do
    {x, y} = position(robot)
    new_position =
      case direction(robot) do
        :north -> {x, y+1}
        :east -> {x+1, y}
        :south -> {x, y-1}
        :west -> {x-1, y}
      end
    create(direction(robot), new_position)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position(robot) do
    robot.position
  end
end
