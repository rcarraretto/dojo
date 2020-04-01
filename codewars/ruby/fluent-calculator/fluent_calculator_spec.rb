Test.assert_equals(Calc.new.one.plus.two, 3)
Test.assert_equals(Calc.new.two.plus.one, 3)
Test.assert_equals(Calc.new.three.plus.four, 7)
Test.assert_equals(Calc.new.four.plus.three, 7)
Test.assert_equals(Calc.new.five.plus.six, 11)
Test.assert_equals(Calc.new.six.plus.five, 11)
Test.assert_equals(Calc.new.seven.plus.eight, 15)
Test.assert_equals(Calc.new.eight.plus.seven, 15)
Test.assert_equals(Calc.new.nine.plus.zero, 9)
Test.assert_equals(Calc.new.zero.plus.nine, 9)

Test.assert_equals(Calc.new.five.minus.six, -1)

Test.assert_equals(Calc.new.seven.times.two, 14)

Test.assert_equals(Calc.new.nine.divided_by.three, 3)
