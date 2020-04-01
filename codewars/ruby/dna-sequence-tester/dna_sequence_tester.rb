def check_DNA(*seqs)
  (smaller, bigger) = sort(seqs)
  bigger.include? mirror(smaller.reverse)
end

def sort(seqs)
  seqs.sort_by(&:length)
end

def mirror(seq)
  seq.tr('ATCG','TAGC')
end
