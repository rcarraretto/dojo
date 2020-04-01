defmodule NucleotideCount do
  @nucleotides [?A, ?T, ?C, ?G]

  def count(strand, nucleotide) do
    Enum.count strand, &(&1 == nucleotide)
  end

  def histogram(strand) do
    Map.new @nucleotides, &({&1, count(strand, &1)})
  end
end
