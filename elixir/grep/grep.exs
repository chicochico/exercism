defmodule Grep do
  @spec grep(String.t, [String.t], [String.t]) :: String.t
  def grep(pattern, flags, files) do
    flags = %{
      numbers: "-n" in flags,
      files: "-l" in flags,
      ignorecase: "-i" in flags,
      invert: "-v" in flags,
      fullmatch: "-x" in flags
    }

    files
    |> read_files
    |> filter_files(pattern, flags)
    |> format_result(flags)
  end

  @spec read_files(list) :: [{String.t, list}]
  def read_files(files) do
    files
    |> Enum.map(&read_lines(&1))
  end

  @spec read_lines(String.t) :: [{String.t, integer}]
  def read_lines(file) do
    case File.read(file) do
      {:ok, text} ->
        lines =
          text
          |> String.split("\n")
          |> Enum.slice(0..-2)  # remove empy string in the end
          |> Enum.with_index(1)
        {file, lines}
      error -> error
    end
  end

  @spec filter_files([String.t], String.t, map) :: [{String.t, list}]
  def filter_files(files, pattern, flags) do
    files
    |> Enum.map(fn {file, lines} ->
      {file, filter_lines(lines, pattern, flags)}
    end)
  end

  @spec filter_lines([{String.t, integer}], String.t, map) :: [{String.t, list}]
  def filter_lines(lines, pattern, flags) do
    lines
    |> Enum.filter(fn {str, line_no} ->
      contains =
        cond do
          flags.fullmatch and flags.ignorecase ->
            String.downcase(str) == String.downcase(pattern)
          flags.fullmatch ->
            str == pattern
          flags.ignorecase ->
            pattern = String.downcase(pattern)
            str
            |> String.downcase
            |> String.contains?(pattern)
          true ->
            String.contains?(str, pattern)
        end
      # exclsive or
      (contains or flags.invert) and !(contains and flags.invert)
    end)
  end

  @spec format_result([{String.t, list}], map) :: String.t
  def format_result(result, flags) do
    case flags.files do
      true ->
        result
        |> Enum.map(fn {file, lines} ->
          case lines do
            [] -> []
            _ -> file
          end
        end)
      false ->
        multiple = length(result) > 1
        result
        |> Enum.map(&format_lines(&1, flags, multiple))
    end
    |> List.flatten
    |> Enum.reduce("", fn line, acc ->
      acc <> line <> "\n"
    end)
  end

  @spec format_lines({String.t, list}, map, boolean) :: [String.t]
  def format_lines({file, lines}, flags, multiple_files) do
    formatted =
      if flags.numbers do
        add_line_numbers(lines)
      else
        lines
        |> Enum.map(fn {str, _} -> str end)
      end

    if multiple_files do
      add_filename(formatted, file)
    else
      formatted
    end
  end

  @spec add_line_numbers([{String.t, integer}]) :: [String.t]
  def add_line_numbers(lines) do
    lines
    |> Enum.map(fn {str, number} ->
      to_string(number) <> ":" <> str
    end)
  end

  @spec add_filename([String.t], String.t) :: [String.t]
  def add_filename(lines, file) do
    lines
    |> Enum.map(fn str ->
      file <> ":" <> str
    end)
  end
end
