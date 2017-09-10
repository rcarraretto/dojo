#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "isogram.h"

int isIsogram(char *str)
{
	unsigned long len = strlen(str);
	unsigned long i;
	int counts[256] = { 0 };
	unsigned char current;

	for (i = 0; i < len; i++) {
		if (!isalpha(str[i])) {
			continue;
		}
		current = tolower(str[i]);
		if (counts[current]) {
			return 0;
		}
		counts[current]++;
	}

	return 1;
}
