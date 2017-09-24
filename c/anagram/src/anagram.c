#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "anagram.h"

#define NUM_CHARS 26

int* counts_for(char* str, int* counts)
{
  for (int i = 0; i < NUM_CHARS; i++) {
    counts[i] = 0;
  }

  for (char* c = str; *c; c++) {
    if (!isalpha(*c)) {
      continue;
    }
    size_t index = tolower(*c) - 'a';
    counts[index]++;
  }

  return counts;
}

struct Vector anagrams_for(char* str1, struct Vector possible)
{
  struct Vector actual = {
    malloc(possible.size * MAX_STR_LEN),
    0
  };
  int counts1[NUM_CHARS];
  int counts2[NUM_CHARS];

  counts_for(str1, counts1);

  for (int i = 0; i < possible.size; i++) {
    char* str2 = possible.vec[i];

    if (strcasecmp(str1, str2) == 0) {
      continue;
    }

    counts_for(str2, counts2);

    if (memcmp(counts1, counts2, sizeof(counts1)) != 0) {
      continue;
    }

    strcpy(actual.vec[actual.size], str2);
    actual.size++;
  }

  return actual;
}
