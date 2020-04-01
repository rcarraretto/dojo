/*
ID: r_carra1
LANG: C
TASK: gift1
*/
#include <stdio.h>
#include <string.h>
#include <assert.h>

#define MAX_PEOPLE 10
#define MAX_NAME 14

typedef struct Gift {
  char giver[MAX_NAME];
  int amount;
  int num_receivers;
  char receivers[MAX_NAME][MAX_PEOPLE];
} Gift;

typedef struct Input {
  int num_people;
  char names[MAX_NAME][MAX_PEOPLE];
  struct Gift gifts[MAX_PEOPLE];
} Input;


typedef struct Gain {
  char name[MAX_NAME];
  int amount;
} Gain;

typedef struct Output {
  int num_people;
  struct Gain gains[MAX_PEOPLE];
} Output;


void print(Output output) {
  for (int i = 0; i < output.num_people; i++) {
    printf("%s %d\n", output.gains[i].name, output.gains[i].amount);
  }
  printf("\n");
}

Output init_output(Input* input) {
  Output output;

  output.num_people = input->num_people;

  for (int i = 0; i < input->num_people; i++) {
    strcpy(output.gains[i].name, input->names[i]);
    output.gains[i].amount = 0;
  }

  return output;
}

Gain* find_person(Output* output, char* name) {
  Gain* gain;
  for (int i = 0; i < output->num_people; i++) {
    gain = &output->gains[i];
    if (strcmp(gain->name, name) == 0) {
      return gain;
    }
  }
  assert(0);
}

void give_gift(Output* output, Gift gift) {
  int receiver_gain = gift.num_receivers ?
    gift.amount / gift.num_receivers :
    0;

  int giver_loss = receiver_gain * gift.num_receivers;

  Gain* giver = find_person(output, gift.giver);
  giver->amount -= giver_loss;

  for (int i = 0; i < gift.num_receivers; i++) {
    Gain* receiver = find_person(output, gift.receivers[i]);
    receiver->amount += receiver_gain;
  }
}

Output gift1(Input input) {
  Output output = init_output(&input);

  for (int i = 0; i < input.num_people; i++) {
    give_gift(&output, input.gifts[i]);
  }

  return output;
}

Input read(FILE* file) {
  Input input;

  fscanf(file, "%d\n", &input.num_people);

  for (int i = 0; i < input.num_people; i++) {
    fscanf(file, "%s\n", input.names[i]);
  }

  for (int i = 0; i < input.num_people; i++) {
    Gift gift;

    fscanf(file, "%s\n", gift.giver);
    fscanf(file, "%d %d\n", &gift.amount, &gift.num_receivers);

    for (int j = 0; j < gift.num_receivers; j++) {
      fscanf(file, "%s\n", gift.receivers[j]);
    }

    input.gifts[i] = gift;
  }

  return input;
}

void write(FILE* file, Output output) {
  for (int i = 0; i < output.num_people; i++) {
    Gain gain = output.gains[i];
    fprintf(file, "%s %d\n", gain.name, gain.amount);
  }
}

int main() {
  FILE* in_file  = fopen("gift1.in", "r");
  FILE* out_file = fopen("gift1.out", "w");

  Input input = read(in_file);
  Output output = gift1(input);

  write(out_file, output);

  return 0;
}
