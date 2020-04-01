/*
ID: r_carra1
LANG: C
TASK: ride
*/
#include <stdio.h>
#include <string.h>

int letter_num(char c) {
   return c - 'A' + 1;
}

int str_num(char* str) {
   int product = 1;
   for (char* c = str; *c; c++)
      product *= letter_num(*c);
   return product % 47;
}

void ride(char* comet, char* group, char* result) {
   if (str_num(comet) == str_num(group))
      strcpy(result, "GO");
   else
      strcpy(result, "STAY");
}

int main() {
  FILE* in  = fopen("ride.in", "r");
  FILE* out = fopen("ride.out", "w");
  char comet[8];
  char group[8];
  char result[5];

  fgets(comet, sizeof comet, in);
  fgets(group, sizeof group, in);

  ride(comet, group, result);

  fprintf(out, "%s\n", result);

  return 0;
}
