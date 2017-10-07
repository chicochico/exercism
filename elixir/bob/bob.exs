defmodule Bob do
  def hey(input) do
    case listen(input) do
      :silence ->  "Fine. Be that way!"
      :question -> "Sure."
      :shouting -> "Whoa, chill out!"
      :whatever -> "Whatever."
    end
  end

  defp listen(input) do
    cond do
      String.trim(input) == "" ->
        :silence
      String.ends_with?(input, "?") ->
        :question
      String.upcase(input) == input and String.downcase(input) != input ->
        :shouting
      true -> :whatever
    end
  end
end
