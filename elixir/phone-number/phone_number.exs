defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    stripped = strip(raw)

    with true <- valid_input?(raw),
         true <- valid_number?(stripped),
         <<_::binary-size(1), num::binary-size(10)>> <- stripped do
      num
    else
      <<num::binary-size(10)>> -> num
      false -> "0000000000"
    end
  end

  def strip(raw) do
    ~r/\d+/
    |> Regex.scan(raw)
    |> Enum.join
  end

  def valid_number?(<<number::binary-size(10)>>) do
    case number do
      <<area::binary-size(1), _::binary-size(2), exchange::binary-size(1), _::binary>> ->
        r = ~r/[2-9]/
        Regex.match?(r, area) and Regex.match?(r, exchange)
      _ ->
        false
    end
  end
  def valid_number?(<<"1", number::binary-size(10)>>), do: valid_number?(number)
  def valid_number?(_), do: false

  def valid_input?(raw) do
    !Regex.match?(~r/[a-zA-Z]/, raw)
  end

  @doc """
  Extract the area code from a phone number
  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> number
    |> case do
      <<code::binary-size(3), _::binary>> ->
        code
    end
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    raw
    |> number
    |> case do
      <<code::binary-size(3), ex_code::binary-size(3), sub_code::binary>> ->
        "(" <> code <> ") " <> ex_code <> "-" <> sub_code
    end
  end
end
