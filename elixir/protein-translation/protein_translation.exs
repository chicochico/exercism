defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    result =
      rna
      |> chunk
      |> do_translation

    case result do
      [] -> {:error, "invalid RNA"}
      result -> {:ok, result}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case translate(codon) do
      :error -> {:error, "invalid codon"}
      c -> {:ok, c}
    end
  end

  def translate(codon) do
    case codon do
      "UGU" ->
        "Cysteine"
      "UGC" ->
        "Cysteine"
      "UUA" ->
        "Leucine"
      "UUG" ->
        "Leucine"
      "AUG" ->
        "Methionine"
      "UUU" ->
        "Phenylalanine"
      "UUC" ->
        "Phenylalanine"
      "UCU" ->
        "Serine"
      "UCC" ->
        "Serine"
      "UCA" ->
        "Serine"
      "UCG" ->
        "Serine"
      "UGG" ->
        "Tryptophan"
      "UAU" ->
        "Tyrosine"
      "UAC" ->
        "Tyrosine"
      "UAA" ->
        "STOP"
      "UAG" ->
        "STOP"
      "UGA" ->
        "STOP"
      _ ->
        :error
    end
  end

  defp chunk(rna) do
    for  <<c::binary-3 <- rna>>, do: c
  end

  defp do_translation(codons) do
    codons
    |> Enum.reduce_while([], &do_translation(&1, &2))
  end

  defp do_translation(codon, acc) do
    result = translate(codon)
    case result do
      "STOP" -> {:halt, acc}
      :error -> {:halt, acc}
      result -> {:cont, acc ++ [result]}
    end
  end
end

