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
    |> to_charlist
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  @spec encode(charlist, charlist) :: String.t()
  def encode([], acc), do: List.to_string(acc)
  def encode([h|t], acc) do
    encoded =
      case h do
        ?a -> ?z
        ?b -> ?y
        ?c -> ?x
        ?d -> ?w
        ?e -> ?v
        ?f -> ?u
        ?g -> ?t
        ?h -> ?s
        ?i -> ?r
        ?j -> ?q
        ?k -> ?p
        ?l -> ?o
        ?m -> ?n
        ?n -> ?m
        ?o -> ?l
        ?p -> ?k
        ?q -> ?j
        ?r -> ?i
        ?s -> ?h
        ?t -> ?g
        ?u -> ?f
        ?v -> ?e
        ?w -> ?d
        ?x -> ?c
        ?y -> ?b
        ?z -> ?a
        _ -> h
      end
      encode(t, acc ++ [encoded])
  end

  @spec decode(String.t) :: String.t
  def decode(cipher) do
    encode(cipher)
    |> String.replace(" ", "")
  end
end


#```plain
#Plain:  abcdefghijklmnopqrstuvwxyz
#Cipher: zyxwvutsrqponmlkjihgfedcba
#```
