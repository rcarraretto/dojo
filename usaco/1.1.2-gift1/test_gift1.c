#include <stddef.h>
#include "../test/unity.h"
#include "gift1.c"

void test_sample(void)
{
   Input input = {
      5,
      { "dave", "laura", "owen", "vick", "amr" },
      {
         { "dave",  200, 3, { "laura", "owen", "vick" } },
         { "owen",  500, 1, { "dave" } },
         { "amr",   150, 2, { "vick",  "owen" } },
         { "laura", 0,   2, { "amr",   "vick" } },
         { "vick",  0,   0, { "" } },
      }
   };
   Output output = gift1(input);

   TEST_ASSERT_EQUAL_STRING("dave", output.gains[0].name);
   TEST_ASSERT_EQUAL_INT(302, output.gains[0].amount);

   TEST_ASSERT_EQUAL_STRING("laura", output.gains[1].name);
   TEST_ASSERT_EQUAL_INT(66, output.gains[1].amount);

   TEST_ASSERT_EQUAL_STRING("owen", output.gains[2].name);
   TEST_ASSERT_EQUAL_INT(-359, output.gains[2].amount);

   TEST_ASSERT_EQUAL_STRING("vick", output.gains[3].name);
   TEST_ASSERT_EQUAL_INT(141, output.gains[3].amount);

   TEST_ASSERT_EQUAL_STRING("amr", output.gains[4].name);
   TEST_ASSERT_EQUAL_INT(-150, output.gains[4].amount);
}

int main(void)
{
   UnityBegin("test/test_hello_world.c");

   RUN_TEST(test_sample);

   UnityEnd();

   return 0;
}
