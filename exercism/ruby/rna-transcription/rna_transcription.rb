class Complement
  def self.of_dna(dna)
    rna = dna.chars.map { |n| dna_to_rna(n) }.join
    return '' unless rna.length == dna.length
    rna
  end

  def self.dna_to_rna(dna_n)
    {
      'G' => 'C',
      'C' => 'G',
      'T' => 'A',
      'A' => 'U'
    }[dna_n]
  end
end

module BookKeeping
  VERSION = 4
end
