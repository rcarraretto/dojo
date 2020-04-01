Test.assert_equals(validBraces( "(" ), false)
Test.assert_equals(validBraces( ")" ), false)
Test.assert_equals(validBraces( ")(" ), false)
Test.assert_equals(validBraces( "()" ), true)
Test.assert_equals(validBraces( "(()" ), false)
Test.assert_equals(validBraces( "())" ), false)
Test.assert_equals(validBraces( "()(" ), false)

Test.assert_equals(validBraces( "[" ), false)
Test.assert_equals(validBraces( "]" ), false)
Test.assert_equals(validBraces( "][" ), false)
Test.assert_equals(validBraces( "[]" ), true)

Test.assert_equals(validBraces( "{" ), false)
Test.assert_equals(validBraces( "}" ), false)
Test.assert_equals(validBraces( "}{" ), false)
Test.assert_equals(validBraces( "{}" ), true)

Test.assert_equals(validBraces( "([])" ), true)
Test.assert_equals(validBraces( "(][)" ), false)
Test.assert_equals(validBraces( ")[](" ), false)

Test.assert_equals(validBraces( "(){}[]" ), true)
Test.assert_equals(validBraces( "([{}])" ), true)
