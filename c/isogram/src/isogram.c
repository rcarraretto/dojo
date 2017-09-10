#include <string.h>
#include <ctype.h>
#include "isogram.h"

bool isIsogram(char *str)
{
	size_t len = strlen(str);
	int counts[26] = { 0 };

	for (size_t i = 0; i < len; i++) {
		if (!isalpha(str[i])) {
			continue;
		}
		size_t index = tolower(str[i]) - 'a';
		if (counts[index]) {
			return false;
		}
		counts[index]++;
	}

	return true;
}
