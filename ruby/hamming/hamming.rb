class Hamming
  def self.compute(strand1, strand2)
    raise ArgumentError unless strand1.length == strand2.length
    self.nucleotide_diff(strand1.chars, strand2.chars)
  end

  def self.nucleotide_diff(n1, n2)
    n1.zip(n2).count { |pair| pair[0] != pair[1] }
  end
end

module BookKeeping
  VERSION = 3
end
