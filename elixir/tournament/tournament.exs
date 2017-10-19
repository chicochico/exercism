defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.reduce(%{}, fn record, acc ->
      case record do
        [team_a, team_b, "win"] ->
          Map.update(acc, team_a, [1, 1, 0, 0, 3], &update_tally("win", &1))
          |> Map.update(team_b, [1, 0, 0, 1, 0], &update_tally("loss", &1))
        [team_a, team_b, "draw"] ->
          Map.update(acc, team_a, [1, 0, 1, 0, 1], &update_tally("draw", &1))
          |> Map.update(team_b, [1, 0, 1, 0, 1], &update_tally("draw", &1))
        [team_a, team_b, "loss"] ->
          Map.update(acc, team_a, [1, 0, 0, 1, 0], &update_tally("loss", &1))
          |> Map.update(team_b, [1, 1, 0, 0, 3], &update_tally("win", &1))
        _ -> acc
      end
    end)
    |> Enum.sort(fn {_, [_, _, _, _, s1]}, {_, [_, _, _, _, s2]} ->
      s1 >= s2
    end)
    |> format_tally
  end

  def format_tally(tally) do
    header = "Team                           | MP |  W |  D |  L |  P\n"
    tally
    |> Enum.reduce(header, fn {team, [mp, w, d, l, p]}, acc ->
      acc
      <> String.pad_trailing(team, 31)
      <> "|" <> String.pad_leading(to_string(mp), 3) <> " "
      <> "|" <> String.pad_leading(to_string(w), 3) <> " "
      <> "|" <> String.pad_leading(to_string(d), 3) <> " "
      <> "|" <> String.pad_leading(to_string(l), 3) <> " "
      <> "|" <> String.pad_leading(to_string(p), 3)
      <> "\n"
    end)
    |> String.trim
  end

  # [MP, W, D, L, P]
  def update_tally("win", tally) do
    tally
    |> List.update_at(0, &(&1 + 1))
    |> List.update_at(1, &(&1 + 1))
    |> List.update_at(4, &(&1 + 3))
  end
  def update_tally("draw", tally) do
    tally
    |> List.update_at(0, &(&1 + 1))
    |> List.update_at(2, &(&1 + 1))
    |> List.update_at(4, &(&1 + 1))
  end
  def update_tally("loss", tally) do
    tally
    |> List.update_at(0, &(&1 + 1))
    |> List.update_at(3, &(&1 + 1))
  end
end

