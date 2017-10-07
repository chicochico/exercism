defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) when is_binary(phrase) do
    phrase
    |> split_phrase
    |> translate
    |> join_phrase
  end

  def translate(phrase) when is_list(phrase) do
    Enum.reduce(phrase, [], &(&2 ++ [to_pig_latin &1]))
  end

  def to_pig_latin("a" <> _= word), do: word <> "ay"
  def to_pig_latin("e" <> _= word), do: word <> "ay"
  def to_pig_latin("i" <> _= word), do: word <> "ay"
  def to_pig_latin("o" <> _= word), do: word <> "ay"
  def to_pig_latin("u" <> _= word), do: word <> "ay"
  def to_pig_latin("xr" <> _= word), do: word <> "ay"
  def to_pig_latin("yt" <> _= word), do: word <> "ay"
  def to_pig_latin("ch" <> rest), do: rest <> "ch" <> "ay"
  def to_pig_latin("qu" <> rest), do: rest <> "qu" <> "ay"
  def to_pig_latin("thr" <> rest), do: rest <> "thr" <> "ay"
  def to_pig_latin("th" <> rest), do: rest <> "th" <> "ay"
  def to_pig_latin("sch" <> rest), do: rest <> "sch" <> "ay"
  def to_pig_latin("str" <> rest), do: rest <> "str" <> "ay"
  def to_pig_latin("squ" <> rest), do: rest <> "squ" <> "ay"
  def to_pig_latin(<<first::binary-size(1), rest::binary>>), do: to_pig_latin(rest <> first)

  defp split_phrase(phrase) do
    String.split(phrase, "\s")
  end

  defp join_phrase(phrase) do
    Enum.join(phrase, " ")
  end
end

