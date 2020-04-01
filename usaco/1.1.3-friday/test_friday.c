#include <stddef.h>
#include "../test/unity.h"
#include "friday.c"

void test_mon_to_tue(void)
{
   Day day = { 1900, JANUARY, 1, MONDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(1900, next.year);
   TEST_ASSERT_EQUAL_INT(JANUARY, next.month);
   TEST_ASSERT_EQUAL_INT(2, next.day);
   TEST_ASSERT_EQUAL_INT(TUESDAY, next.day_of_week);
}

void test_tue_to_wed(void)
{
   Day day = { 1900, JANUARY, 2, TUESDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(1900, next.year);
   TEST_ASSERT_EQUAL_INT(JANUARY, next.month);
   TEST_ASSERT_EQUAL_INT(3, next.day);
   TEST_ASSERT_EQUAL_INT(WEDNESDAY, next.day_of_week);
}

void test_wed_to_thu(void)
{
   Day day = { 1900, JANUARY, 3, WEDNESDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(1900, next.year);
   TEST_ASSERT_EQUAL_INT(JANUARY, next.month);
   TEST_ASSERT_EQUAL_INT(4, next.day);
   TEST_ASSERT_EQUAL_INT(THURSDAY, next.day_of_week);
}

void test_thu_to_fri(void)
{
   Day day = { 1900, JANUARY, 4, THURSDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(1900, next.year);
   TEST_ASSERT_EQUAL_INT(JANUARY, next.month);
   TEST_ASSERT_EQUAL_INT(5, next.day);
   TEST_ASSERT_EQUAL_INT(FRIDAY, next.day_of_week);
}

void test_fri_to_sat(void)
{
   Day day = { 1900, JANUARY, 5, FRIDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(1900, next.year);
   TEST_ASSERT_EQUAL_INT(JANUARY, next.month);
   TEST_ASSERT_EQUAL_INT(6, next.day);
   TEST_ASSERT_EQUAL_INT(SATURDAY, next.day_of_week);
}

void test_sat_to_sun(void)
{
   Day day = { 1900, JANUARY, 6, SATURDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(1900, next.year);
   TEST_ASSERT_EQUAL_INT(JANUARY, next.month);
   TEST_ASSERT_EQUAL_INT(7, next.day);
   TEST_ASSERT_EQUAL_INT(SUNDAY, next.day_of_week);
}

void test_sun_to_mon(void)
{
   Day day = { 1900, JANUARY, 7, SUNDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(1900, next.year);
   TEST_ASSERT_EQUAL_INT(JANUARY, next.month);
   TEST_ASSERT_EQUAL_INT(8, next.day);
   TEST_ASSERT_EQUAL_INT(MONDAY, next.day_of_week);
}



void test_jan_to_feb(void)
{
   Day day = { 2017, JANUARY, 31, TUESDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2017, next.year);
   TEST_ASSERT_EQUAL_INT(FEBRUARY, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(WEDNESDAY, next.day_of_week);
}

void test_feb_to_mar(void)
{
   Day day = { 2017, FEBRUARY, 28, TUESDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2017, next.year);
   TEST_ASSERT_EQUAL_INT(MARCH, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(WEDNESDAY, next.day_of_week);
}

void test_feb_to_mar_leap(void)
{
   Day day = { 2016, FEBRUARY, 29, MONDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2016, next.year);
   TEST_ASSERT_EQUAL_INT(MARCH, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(TUESDAY, next.day_of_week);
}

void test_mar_to_apr(void)
{
   Day day = { 2017, MARCH, 31, FRIDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2017, next.year);
   TEST_ASSERT_EQUAL_INT(APRIL, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(SATURDAY, next.day_of_week);
}

void test_apr_to_may(void)
{
   Day day = { 2017, APRIL, 30, SUNDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2017, next.year);
   TEST_ASSERT_EQUAL_INT(MAY, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(MONDAY, next.day_of_week);
}

void test_may_to_jun(void)
{
   Day day = { 2017, MAY, 31, WEDNESDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2017, next.year);
   TEST_ASSERT_EQUAL_INT(JUNE, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(THURSDAY, next.day_of_week);
}

void test_jun_to_jul(void)
{
   Day day = { 2017, JUNE, 30, FRIDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2017, next.year);
   TEST_ASSERT_EQUAL_INT(JULY, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(SATURDAY, next.day_of_week);
}

void test_jul_to_aug(void)
{
   Day day = { 2017, JULY, 31, MONDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2017, next.year);
   TEST_ASSERT_EQUAL_INT(AUGUST, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(TUESDAY, next.day_of_week);
}

void test_aug_to_sep(void)
{
   Day day = { 2017, AUGUST, 31, THURSDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2017, next.year);
   TEST_ASSERT_EQUAL_INT(SEPTEMBER, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(FRIDAY, next.day_of_week);
}

void test_sep_to_oct(void)
{
   Day day = { 2017, SEPTEMBER, 30, SATURDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2017, next.year);
   TEST_ASSERT_EQUAL_INT(OCTOBER, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(SUNDAY, next.day_of_week);
}

void test_oct_to_nov(void)
{
   Day day = { 2017, OCTOBER, 31, TUESDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2017, next.year);
   TEST_ASSERT_EQUAL_INT(NOVEMBER, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(WEDNESDAY, next.day_of_week);
}

void test_nov_to_dec(void)
{
   Day day = { 2017, NOVEMBER, 30, THURSDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2017, next.year);
   TEST_ASSERT_EQUAL_INT(DECEMBER, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(FRIDAY, next.day_of_week);
}

void test_dec_to_jan(void)
{
   Day day = { 2017, DECEMBER, 31, SUNDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2018, next.year);
   TEST_ASSERT_EQUAL_INT(JANUARY, next.month);
   TEST_ASSERT_EQUAL_INT(1, next.day);
   TEST_ASSERT_EQUAL_INT(MONDAY, next.day_of_week);
}



void test_feb_leap_has_extra_day(void)
{
   Day day = { 2016, FEBRUARY, 28, SUNDAY };
   Day next = next_day(day);

   TEST_ASSERT_EQUAL_INT(2016, next.year);
   TEST_ASSERT_EQUAL_INT(FEBRUARY, next.month);
   TEST_ASSERT_EQUAL_INT(29, next.day);
   TEST_ASSERT_EQUAL_INT(MONDAY, next.day_of_week);
}



void test_leap_year(void)
{
   TEST_ASSERT_EQUAL_INT(0, is_leap_year(1700));
   TEST_ASSERT_EQUAL_INT(0, is_leap_year(1800));
   TEST_ASSERT_EQUAL_INT(0, is_leap_year(1900));
   TEST_ASSERT_EQUAL_INT(1, is_leap_year(2000));
   TEST_ASSERT_EQUAL_INT(0, is_leap_year(2100));
}



void test_friday_n1(void)
{
   int times[NUM_WEEK_DAYS] = { 0 };
   friday(1, times);
   TEST_ASSERT_EQUAL_INT(2, times[SATURDAY]);
   TEST_ASSERT_EQUAL_INT(1, times[SUNDAY]);
   TEST_ASSERT_EQUAL_INT(1, times[MONDAY]);
   TEST_ASSERT_EQUAL_INT(3, times[TUESDAY]);
   TEST_ASSERT_EQUAL_INT(1, times[WEDNESDAY]);
   TEST_ASSERT_EQUAL_INT(2, times[THURSDAY]);
   // April 13, 1900
   // July 13, 1900
   TEST_ASSERT_EQUAL_INT(2, times[FRIDAY]);
}

void test_friday_n20(void)
{
   int times[NUM_WEEK_DAYS] = { 0 };
   friday(20, times);
   TEST_ASSERT_EQUAL_INT(36, times[SATURDAY]);
   TEST_ASSERT_EQUAL_INT(33, times[SUNDAY]);
   TEST_ASSERT_EQUAL_INT(34, times[MONDAY]);
   TEST_ASSERT_EQUAL_INT(33, times[TUESDAY]);
   TEST_ASSERT_EQUAL_INT(35, times[WEDNESDAY]);
   TEST_ASSERT_EQUAL_INT(35, times[THURSDAY]);
   TEST_ASSERT_EQUAL_INT(34, times[FRIDAY]);
}



int main(void)
{
   UnityBegin("friday");

   RUN_TEST(test_mon_to_tue);
   RUN_TEST(test_tue_to_wed);
   RUN_TEST(test_wed_to_thu);
   RUN_TEST(test_thu_to_fri);
   RUN_TEST(test_fri_to_sat);
   RUN_TEST(test_sat_to_sun);
   RUN_TEST(test_sun_to_mon);

   RUN_TEST(test_jan_to_feb);
   RUN_TEST(test_feb_to_mar);
   RUN_TEST(test_feb_to_mar_leap);
   RUN_TEST(test_mar_to_apr);
   RUN_TEST(test_apr_to_may);
   RUN_TEST(test_may_to_jun);
   RUN_TEST(test_jun_to_jul);
   RUN_TEST(test_jul_to_aug);
   RUN_TEST(test_aug_to_sep);
   RUN_TEST(test_sep_to_oct);
   RUN_TEST(test_oct_to_nov);
   RUN_TEST(test_nov_to_dec);
   RUN_TEST(test_dec_to_jan);

   RUN_TEST(test_feb_leap_has_extra_day);

   RUN_TEST(test_leap_year);

   RUN_TEST(test_friday_n1);
   RUN_TEST(test_friday_n20);

   UnityEnd();

   return 0;
}
