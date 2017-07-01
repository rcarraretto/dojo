defmodule ProteinTranslation do

  @codon_to_amino_acid %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }

  def of_rna(rna) do
    _of_rna(rna, [])
  end

  defp _of_rna("", acc), do: { :ok, Enum.reverse(acc) }

  defp _of_rna(rna, acc) do
    case rna do
      << codon :: bytes-size(3), tail :: binary >> ->
        case of_codon(codon) do
          { :error, _ } -> { :error, "invalid RNA" }
          { :ok, "STOP" } -> _of_rna("", acc)
          { :ok, amino_acid } -> _of_rna(tail, [amino_acid | acc])
        end
    end
  end

  def of_codon(codon) do
    case @codon_to_amino_acid[codon] do
      nil -> { :error, "invalid codon" }
      amino_acid -> { :ok, amino_acid }
    end
  end
end
