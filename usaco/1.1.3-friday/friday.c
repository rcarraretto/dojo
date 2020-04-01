/*
ID: r_carra1
LANG: C
TASK: friday
*/
#include <stdio.h>

typedef enum {
  JANUARY,
  FEBRUARY,
  MARCH,
  APRIL,
  MAY,
  JUNE,
  JULY,
  AUGUST,
  SEPTEMBER,
  OCTOBER,
  NOVEMBER,
  DECEMBER,
  NUM_MONTHS,
} Month;

typedef enum {
  SATURDAY,
  SUNDAY,
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY,
  NUM_WEEK_DAYS,
} DayOfWeek;

typedef struct {
  short year;
  Month month;
  short day;
  DayOfWeek day_of_week;
} Day;

int is_leap_year(int year) {
  if (year % 100 == 0) {
    return year % 400 == 0;
  }
  return year % 4 == 0;
}

int last_day_of_month(Day day) {
  int num_days_month;
  switch (day.month) {
    case FEBRUARY:
      num_days_month = is_leap_year(day.year) ? 29 : 28;
      break;
    case APRIL:
    case JUNE:
    case SEPTEMBER:
    case NOVEMBER:
      num_days_month = 30;
      break;
    default:
      num_days_month = 31;
  }
  return day.day == num_days_month;
}

Day next_day(Day day) {
  if (last_day_of_month(day)) {
    if (day.month == DECEMBER) {
      day.year++;
    }
    day.month = (day.month + 1) % NUM_MONTHS;
    day.day = 1;
  } else {
    day.day++;
  }
  day.day_of_week = (day.day_of_week + 1) % NUM_WEEK_DAYS;
  return day;
}

void friday(int n, int* times) {
  Day day = { 1900, JANUARY, 1, MONDAY };
  int stop_year = 1900 + n;
  while (day.year != stop_year) {
    if (day.day == 13) {
      times[day.day_of_week]++;
    }
    day = next_day(day);
  }
}

#ifndef TEST

int main() {
  FILE* in  = fopen("friday.in", "r");
  FILE* out = fopen("friday.out", "w");

  int n;
  int times[NUM_WEEK_DAYS] = { 0 };

  fscanf(in, "%d\n", &n);

  friday(n, times);

  for (int i = 0; i < NUM_WEEK_DAYS; i++) {
    fprintf(out, "%d", times[i]);
    if (i != NUM_WEEK_DAYS - 1) {
      fprintf(out, " ");
    }
  }
  fprintf(out, "\n");

  return 0;
}

#endif
