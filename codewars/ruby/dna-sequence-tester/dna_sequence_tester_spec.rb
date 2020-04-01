Test.describe('* Basic Tests *') do
  Test.it('Testing for GTCTTAGTGTAGCTATGCATGC and GCATGCATAGCTACACTACGAC') do
    Test.assert_equals(check_DNA('GTCTTAGTGTAGCTATGCATGC','GCATGCATAGCTACACTACGAC'),false)
  end
  Test.it('Testing for ATGCTACG and CGTAGCAT') do
    Test.assert_equals(check_DNA('ATGCTACG','CGTAGCAT'),true)
  end
  Test.it('Testing for AGTCTGTATGCATCGTACCC and GGGTACGATGCATACAGACT') do
    Test.assert_equals(check_DNA('AGTCTGTATGCATCGTACCC','GGGTACGATGCATACAGACT'),true)
  end
  Test.it('Testing for TGCTACGTACGATCGACGATCCACGAC and GTCGTGGATCGTCGATCGTACGTAGCA') do
    Test.assert_equals(check_DNA('TGCTACGTACGATCGACGATCCACGAC','GTCGTGGATCGTCGATCGTACGTAGCA'),true)
  end
  Test.it('Testing for ATGCCTACGGCCATATATATTTAG and CTAAATATGTATGGCCGTAGGCAT') do
    Test.assert_equals(check_DNA('ATGCCTACGGCCATATATATTTAG','CTAAATATGTATGGCCGTAGGCAT'),false)
  end
  Test.it('Testing for GTCACCGA and TCGGCTGAC') do
    Test.assert_equals(check_DNA('GTCACCGA','TCGGCTGAC'),false)
  end
  Test.it('Testing for TAATACCCGACTAATTCCCC and GGGGAATTTCGGGTATTA') do
    Test.assert_equals(check_DNA('TAATACCCGACTAATTCCCC','GGGGAATTTCGGGTATTA'),false)
  end
  Test.it('Testing for GCTAACTCGAAGCTATACGTTA and TAACGTATAGCTTCGAGGTTAGC') do
    Test.assert_equals(check_DNA('GCTAACTCGAAGCTATACGTTA','TAACGTATAGCTTCGAGGTTAGC'),false)
  end
end

Test.describe('* Sequences of different length *') do
  Test.it('Testing for GCGCTGCTAGCTGATCGA and ACGTACGATCGATCAGCTAGCAGCGCTAC') do
    Test.assert_equals(check_DNA('GCGCTGCTAGCTGATCGA','ACGTACGATCGATCAGCTAGCAGCGCTAC'),true)
  end
  Test.it('Testing for GCTAGCACCCATTAGGAGATAC and CTCCTAATGGGTG') do
    Test.assert_equals(check_DNA('GCTAGCACCCATTAGGAGATAC','CTCCTAATGGGTG'),true)
  end
  Test.it('Testing for TAGCATCGCCAAATTATGCGTCAGTCTGCCCG and GGGCA') do
    Test.assert_equals(check_DNA('TAGCATCGCCAAATTATGCGTCAGTCTGCCCG','GGGCA'),true)
  end
  Test.it('Testing for ACGACTACGTGCGCCGCTAATATT and GCACGGGTCGT') do
    Test.assert_equals(check_DNA('ACGACTACGTGCGCCGCTAATATT','GCACGGGTCGT'),false)
  end
end

Test.describe('* Strands only partially bonded *') do
  Test.it('Testing for CGATACGAACCCATAATCG and CTACACCGGCCGATTATGG') do
    Test.assert_equals(check_DNA('CGATACGAACCCATAATCG','CTACACCGGCCGATTATGG'),false)
  end
  Test.it('Testing for CGACATCGAGGGGGCTCAGAAGTACTGA and CATGGCGTCAGTACTTCTGAGCC') do
    Test.assert_equals(check_DNA('CGACATCGAGGGGGCTCAGAAGTACTGA','CATGGCGTCAGTACTTCTGAGCC'),false)
  end
  Test.it('Testing for GAGCAGTTGGTAGTTT and GTATCGAAACTACCA') do
    Test.assert_equals(check_DNA('GAGCAGTTGGTAGTTT','GTATCGAAACTACCA'),false)
  end
  Test.it('Testing for TACGATCCAAGGCTACTCAGAG and GGGATACTCTGAGTAGCCTTGGAA') do
    Test.assert_equals(check_DNA('TACGATCCAAGGCTACTCAGAG','GGGATACTCTGAGTAGCCTTGGAA'),false)
  end
end
