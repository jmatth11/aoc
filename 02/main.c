#include "../helper/utils.h"
#include "rps.h"
#include <stdio.h>
#include <stdlib.h>

#define LINE_SIZE 10

int main(int argc, char **argv) {
  if (argc < 2) {
    fprintf(stderr, "must supply an input file.");
    return 1;
  }
  char line[LINE_SIZE];
  FILE *inputFile = NULL;
  int sum = 0;
  defer(inputFile = fopen(argv[1], "r"), fclose(inputFile)) {
    if (inputFile == NULL)
      fprintf(stderr, "couldn't open input file.");
    while (fgets(line, LINE_SIZE, inputFile) != NULL) {
      char op, us;
      int err = sscanf(line, "%c %c\n", &op, &us);
      if (err == EOF || err < 0) {
        fprintf(stderr, "error reading line: \"%s\"", line);
      }
      sum += evaluate_game(op, us);
    }
  }
  printf("sum = %d\n", sum);
  return 0;
}
