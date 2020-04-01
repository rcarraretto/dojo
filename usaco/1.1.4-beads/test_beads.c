#include <stddef.h>
#include "../test/unity.h"
#include "beads.c"

void test_all_red(void)
{
   Output output = beads("rrrrr", 5);
   TEST_ASSERT_EQUAL_INT(0, output.shift);
   TEST_ASSERT_EQUAL_INT(5, output.num_collected);
}

void test_all_white(void)
{
   Output output = beads("wwwww", 5);
   TEST_ASSERT_EQUAL_INT(0, output.shift);
   TEST_ASSERT_EQUAL_INT(5, output.num_collected);
}

void test_red_blue(void)
{
   Output output = beads("brbrrrbbbrrrrrbrrbbrbbbbrrrrb", 29);
   TEST_ASSERT_EQUAL_INT(9, output.shift);
   TEST_ASSERT_EQUAL_INT(8, output.num_collected);
}

void test_white(void)
{
   Output output = beads("wwwbbrwrbrbrrbrbrwrwwrbwrwrrb", 29);
   TEST_ASSERT_EQUAL_INT(28, output.shift);
   TEST_ASSERT_EQUAL_INT(11, output.num_collected);
}

void test_misc(void)
{
   Output output;

   output = beads("rwrwrwrwrwrwrwrwrwrwrwrwbwrwbwrwrwrwrwrwrwrwrwrwrwrwrwrwrwrwrwrwrwrwrwrwrwrwr", 77);
   TEST_ASSERT_EQUAL_INT(23, output.shift);
   TEST_ASSERT_EQUAL_INT(74, output.num_collected);

   output = beads("wrbb", 4);
   TEST_ASSERT_EQUAL_INT(0, output.shift);
   TEST_ASSERT_EQUAL_INT(4, output.num_collected);

   output = beads("brbwr", 5);
   TEST_ASSERT_EQUAL_INT(0, output.shift);
   TEST_ASSERT_EQUAL_INT(3, output.num_collected);

   output = beads("brbbwrrrb", 9);
   TEST_ASSERT_EQUAL_INT(4, output.shift);
   TEST_ASSERT_EQUAL_INT(6, output.num_collected);

   output = beads("wwrbww", 6);
   TEST_ASSERT_EQUAL_INT(0, output.shift);
   TEST_ASSERT_EQUAL_INT(6, output.num_collected);
}

int main(void)
{
   UnityBegin("beads");

   RUN_TEST(test_all_red);
   RUN_TEST(test_all_white);
   RUN_TEST(test_red_blue);
   RUN_TEST(test_white);
   RUN_TEST(test_misc);

   UnityEnd();

   return 0;
}
