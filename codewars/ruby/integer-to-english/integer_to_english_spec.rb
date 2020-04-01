Test.assert_equals(int_to_english(12356), 'twelve thousand three hundred fifty six')
Test.assert_equals(int_to_english(2000), 'two thousand')
Test.assert_equals(int_to_english(1000), 'one thousand')
Test.assert_equals(int_to_english(501), 'five hundred one')
Test.assert_equals(int_to_english(131), 'one hundred thirty one')
Test.assert_equals(int_to_english(120), 'one hundred twenty')
Test.assert_equals(int_to_english(101), 'one hundred one')
Test.assert_equals(int_to_english(100), 'one hundred')
Test.assert_equals(int_to_english(98), 'ninty eight')
Test.assert_equals(int_to_english(87), 'eighty seven')
Test.assert_equals(int_to_english(76), 'seventy six')
Test.assert_equals(int_to_english(65), 'sixty five')
Test.assert_equals(int_to_english(54), 'fifty four')
Test.assert_equals(int_to_english(43), 'forty three')
Test.assert_equals(int_to_english(32), 'thirty two')
Test.assert_equals(int_to_english(30), 'thirty')
Test.assert_equals(int_to_english(21), 'twenty one')
Test.assert_equals(int_to_english(20), 'twenty')
Test.assert_equals(int_to_english(19), 'nineteen')
Test.assert_equals(int_to_english(18), 'eighteen')
Test.assert_equals(int_to_english(17), 'seventeen')
Test.assert_equals(int_to_english(16), 'sixteen')
Test.assert_equals(int_to_english(15), 'fifteen')
Test.assert_equals(int_to_english(14), 'fourteen')
Test.assert_equals(int_to_english(13), 'thirteen')
Test.assert_equals(int_to_english(12), 'twelve')
Test.assert_equals(int_to_english(11), 'eleven')
Test.assert_equals(int_to_english(10), 'ten')
Test.assert_equals(int_to_english(9), 'nine')
Test.assert_equals(int_to_english(8), 'eight')
Test.assert_equals(int_to_english(7), 'seven')
Test.assert_equals(int_to_english(6), 'six')
Test.assert_equals(int_to_english(5), 'five')
Test.assert_equals(int_to_english(4), 'four')
Test.assert_equals(int_to_english(3), 'three')
Test.assert_equals(int_to_english(2), 'two')
Test.assert_equals(int_to_english(1), 'one')
Test.assert_equals(int_to_english(0), 'zero')

Test.assert_equals(
	int_to_english(1564684613251584361432138),
	'one septillion ' +
  'five hundred sixty four sextillion ' +
  'six hundred eighty four quintillion ' +
  'six hundred thirteen quadrillion ' +
  'two hundred fifty one trillion ' +
  'five hundred eighty four billion ' +
  'three hundred sixty one million ' +
  'four hundred thirty two thousand ' +
  'one hundred thirty eight'
)
Test.assert_equals(int_to_english(25161045656), 'twenty five billion one hundred sixty one million forty five thousand six hundred fifty six')
