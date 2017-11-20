defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> String.replace(~r/[[:punct:]]|\s/, "")
    |> to_charlist
    |> encode([])
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  @spec encode(charlist, charlist) :: charlist
  def encode([], acc), do: acc
  def encode([h|t], acc) do
    encoded =
      cond do
        h in ?a..?z -> 219 - h
        true -> h
      end
    encode(t, acc ++ [encoded])
  end

  @spec decode(String.t) :: String.t
  def decode(cipher) do
    encode(cipher)
    |> String.replace(" ", "")
  end
end
