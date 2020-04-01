#include <stddef.h>
#include "../test/unity.h"
#include "ride.h"

void test_valid_comet_group(void)
{
   char result[4];
   ride("COMETQ", "HVNGAT", result);
   TEST_ASSERT_EQUAL_STRING("GO", result);
}

void test_valid_comet_group2(void)
{
   char result[4];
   ride("EARTH", "LEFTB", result);
   TEST_ASSERT_EQUAL_STRING("GO", result);
}

void test_invalid_comet(void)
{
   char result[4];
   ride("COMETX", "HVNGAT", result);
   TEST_ASSERT_EQUAL_STRING("STAY", result);
}

void test_invalid_group(void)
{
   char result[4];
   ride("COMETQ", "XVNGAT", result);
   TEST_ASSERT_EQUAL_STRING("STAY", result);
}

void test_invalid(void)
{
   char result[4];
   ride("STARAB", "USACO", result);
   TEST_ASSERT_EQUAL_STRING("STAY", result);
}

void test_unaffected_by_newline(void)
{
   char result[4];
   ride("COMETQ\n", "HVNGAT\n", result);
   TEST_ASSERT_EQUAL_STRING("GO", result);

   ride("STARAB\n", "USACO\n", result);
   TEST_ASSERT_EQUAL_STRING("STAY", result);
}

int main(void)
{
   UnityBegin("test/test_hello_world.c");

   RUN_TEST(test_valid_comet_group);
   RUN_TEST(test_valid_comet_group2);
   RUN_TEST(test_invalid_comet);
   RUN_TEST(test_invalid_group);
   RUN_TEST(test_invalid);
   RUN_TEST(test_unaffected_by_newline);

   UnityEnd();

   return 0;
}
