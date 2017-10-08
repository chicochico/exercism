defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    ~r/([a-zA-Z\s])\1*/
    |> Regex.scan(string, capture: :first)
    |> List.flatten
    |> Enum.reduce("", &pack(&1, &2))
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    ~r/\d+[a-zA-Z\s]|[a-zA-Z\s]/
    |> Regex.scan(string, capture: :first)
    |> List.flatten
    |> Enum.reduce("", &unpack(&1, &2))
  end

  def pack(<<c::binary-size(1), "">>, acc), do: acc <> c

  def pack(<<c::binary-size(1), rest::binary>>, acc) do
    char_count = String.length(rest) + 1 |> to_string
    acc <> char_count <> c
  end

  def unpack(<<chunk::binary-size(1)>>, acc) do
    acc <> chunk
  end

  def unpack(chunk, acc) do
    [count, char] =
      ~r/\d+|[a-zA-Z\s]/
      |> Regex.scan(chunk)
      |> List.flatten

    count = String.to_integer(count)
    acc <> String.duplicate(char, count)
  end
end
