#include <string.h>
#include <ctype.h>
#include "isogram.h"

bool isIsogram(char* str)
{
  int counts[26] = { 0 };

  for (char* c = str; *c; c++) {
    if (!isalpha(*c)) {
      continue;
    }
    size_t index = tolower(*c) - 'a';
    if (counts[index]) {
      return false;
    }
    counts[index]++;
  }

  return true;
}
