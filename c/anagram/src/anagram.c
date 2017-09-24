#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "anagram.h"

#define NUM_CHARS 26

void set_counts(char* str, int* counts)
{
  memset(counts, 0, NUM_CHARS * sizeof(int));

  for (char* c = str; *c; c++) {
    if (!isalpha(*c)) {
      continue;
    }
    size_t index = tolower(*c) - 'a';
    counts[index]++;
  }
}

struct Vector anagrams_for(char* str1, struct Vector possible)
{
  struct Vector actual = {
    malloc(possible.size * MAX_STR_LEN * sizeof(char)),
    0
  };
  int counts1[NUM_CHARS];
  int counts2[NUM_CHARS];

  set_counts(str1, counts1);

  for (int i = 0; i < possible.size; i++) {
    char* str2 = possible.vec[i];

    if (strcasecmp(str1, str2) == 0) {
      continue;
    }

    set_counts(str2, counts2);

    if (memcmp(counts1, counts2, sizeof(counts1)) != 0) {
      continue;
    }

    strcpy(actual.vec[actual.size], str2);
    actual.size++;
  }

  return actual;
}
