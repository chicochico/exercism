defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t) :: String.t
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&process(&1))
    |> Enum.join
    |> patch
  end

  defp process(text) do
    case text do
      "#" <> _ ->
        text
        |> parse_header_md_level
        |> enclose_with_header_tag
      "*" <> _ ->
        parse_list_md_level(text)
      _ ->
        text
        |> String.split
        |> enclose_with_paragraph_tag
    end
  end

  defp parse_header_md_level(header) do
    [h|t] = String.split(header)
    weight = String.length(h) |> to_string
    text = Enum.join(t, " ")

    {weight, text}
  end

  defp parse_list_md_level(level) do
    text =
      level
      |> String.trim_leading("* ")
      |> String.split
      |> join_words_with_tags

    "<li>" <> text <> "</li>"
  end

  defp enclose_with_header_tag({weight, text}) do
    "<h#{weight}>#{text}</h#{weight}>"
  end

  defp enclose_with_paragraph_tag(text) do
    "<p>#{join_words_with_tags(text)}</p>"
  end

  defp join_words_with_tags(text) do
    text
    |> Enum.map(&replace_md_with_tag(&1))
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md
    |> replace_suffix_md
  end

  defp replace_prefix_md(word) do
    cond do
      word =~ ~r/^#{"__"}{1}/ -> String.replace(word, "__", "<strong>", global: false)
      word =~ ~r/^#{"_"}+/ -> String.replace(word, "_", "<em>", global: false)
      true -> word
    end
  end

  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/#{"__"}/ -> String.replace(word, "__", "</strong>")
      word =~ ~r/#{"_"}/ -> String.replace(word, "_", "</em>")
      true -> word
    end
  end

  defp patch(list) do
    list
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
