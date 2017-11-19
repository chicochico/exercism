defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  @spec encode(String.t(), String.t()) :: String.t()
  def encode(plaintext, key) do
    process(:encode, plaintext, key)
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  @spec decode(String.t(), String.t()) :: String.t()
  def decode(ciphertext, key) do
    process(:decode, ciphertext, key)
  end

  @spec process(atom, String.t(), String.t()) :: String.t()
  def process(type, text, key) do
    text = to_charlist(text)
    key =
      key
      |> to_charlist
      |> Stream.cycle
      |> Enum.take(length text)
    fun = case type do
      :encode -> &encode_char/2
      :decode -> &decode_char/2
    end

    for {c, k} <- Enum.zip(text, key) do
      if c in ?a..?z do
        fun.(c, k)
      else
        c
      end
    end
    |> List.to_string
  end

  @spec encode_char(integer, integer) :: integer
  defp encode_char(c, k) do
    rem((c-97)+(k-97), 26) + 97
  end

  @spec decode_char(integer, integer) :: integer
  defp decode_char(c, k) do
    rem((c-97)-(k-97)+26, 26) + 97
  end
end

