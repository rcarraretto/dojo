Test.assert_equals(
  line(1, 2),
  "1 1"
)
Test.assert_equals(
  line(1, 3),
  "1   1"
)
Test.assert_equals(
  pattern(0),
  ""
)
Test.assert_equals(
  pattern(1),
  "1"
)
Test.assert_equals(
  pattern(2),
  "1 1\n" +
  " 2 \n" +
  "1 1"
)
Test.assert_equals(
  pattern(3),
  "1   1\n" +
  " 2 2 \n" +
  "  3  \n" +
  " 2 2 \n" +
  "1   1"
)
Test.assert_equals(
  pattern(15),
  "1                           1\n" +
  " 2                         2 \n" +
  "  3                       3  \n" +
  "   4                     4   \n" +
  "    5                   5    \n" +
  "     6                 6     \n" +
  "      7               7      \n" +
  "       8             8       \n" +
  "        9           9        \n" +
  "         0         0         \n" +
  "          1       1          \n" +
  "           2     2           \n" +
  "            3   3            \n" +
  "             4 4             \n" +
  "              5              \n" +
  "             4 4             \n" +
  "            3   3            \n" +
  "           2     2           \n" +
  "          1       1          \n" +
  "         0         0         \n" +
  "        9           9        \n" +
  "       8             8       \n" +
  "      7               7      \n" +
  "     6                 6     \n" +
  "    5                   5    \n" +
  "   4                     4   \n" +
  "  3                       3  \n" +
  " 2                         2 \n" +
  "1                           1"
)

