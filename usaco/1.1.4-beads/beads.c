/*
ID: r_carra1
LANG: C
TASK: beads
*/
#include <stdio.h>

typedef struct {
  char* beads;
  int n;
  int shift;
} BrokenNecklace;

typedef struct {
  int shift;
  int num_collected;
} Output;

char color_at(BrokenNecklace nl, int i) {
  return nl.beads[i % nl.n];
}

int collect_bead(BrokenNecklace nl, int i, char* current_color) {
  char bead_color = color_at(nl, i);

  if (!*current_color || *current_color == 'w') {
    *current_color = bead_color;
  }

  if (bead_color == 'w') {
    return 1;
  }
  return bead_color == *current_color;
}

int collect_right(BrokenNecklace nl, int num_collected) {
  char current_color = '\0';

  for (int i = nl.shift; num_collected < nl.n; i++, num_collected++) {
    if (!collect_bead(nl, i, &current_color)) {
      break;
    }
  }

  return num_collected;
}

int collect_left(BrokenNecklace nl, int num_collected) {
  char current_color = '\0';

  for (int i = nl.n - 1 + nl.shift; num_collected < nl.n; i--, num_collected++) {
    if (!collect_bead(nl, i, &current_color)) {
      break;
    }
  }

  return num_collected;
}

int collect_beads(BrokenNecklace nl) {
  int num_collected = 0;
  num_collected = collect_right(nl, num_collected);
  num_collected = collect_left(nl, num_collected);
  return num_collected;;
}

Output beads(char* beads, int n) {
  Output output = { 0, 0 };

  for (int shift = 0; shift < n; shift++) {

    BrokenNecklace nl = { beads, n, shift };
    int num_collected = collect_beads(nl);

    if (num_collected > output.num_collected) {
      output.num_collected = num_collected;
      output.shift = shift;
    }
  }

  return output;
}

#ifndef TEST

int main() {
  FILE* in  = fopen("beads.in", "r");
  FILE* out = fopen("beads.out", "w");

  int n;
  char b[351];

  fscanf(in, "%d\n", &n);
  fscanf(in, "%350s", b);

  Output output = beads(b, n);

  fprintf(out, "%d\n", output.num_collected);

  return 0;
}

#endif
