#include "../helper/array.h"
#include "../helper/utils.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LINE_SIZE 20

/**
 * Context object for callback.
 */
struct context {
  FILE *inputFile;
  struct array_t *topCalories;
};

void insert_top_calories(struct array_t *const arr, int curMax) {
  if (arr->len < arr->cap) {
    arr->add(arr, curMax);
    return;
  }
  for (int i = 0; i < arr->len; ++i) {
    int tmp = arr->data[i];
    if (curMax > tmp) {
      arr->data[i] = curMax;
      curMax = tmp;
    }
  }
}

int add(struct array_t const *const arr) {
  int result = 0;
  for (int i = 0; i < arr->len; ++i) {
    result += arr->data[i];
  }
  return result;
}

void *execute(void *context) {
  struct context *con = (struct context *)context;
  char line[LINE_SIZE];
  int curMax = 0;
  if (con->inputFile == NULL)
    fprintf(stderr, "couldn't open input file.");
  while (fgets(line, LINE_SIZE, con->inputFile) != NULL) {
    if (strcmp(line, "\n") == 0) {
      insert_top_calories(con->topCalories, curMax);
      curMax = 0;
      continue;
    }
    curMax = curMax + strtol(line, NULL, 10);
  }
  insert_top_calories(con->topCalories, curMax);
  return NULL;
}

int main(int argc, char **argv) {
  if (argc < 2) {
    fprintf(stderr, "must supply an input file.");
    return 1;
  }
  int topN = 1;
  if (argc > 2) {
    topN = strtol(argv[2], NULL, 10);
  }
  struct array_t topCalories;
  array_init(&topCalories, topN);
  FILE *inputFile = NULL;
  defer(inputFile = fopen(argv[1], "r"), fclose(inputFile)) {
    struct context con = {.inputFile = inputFile, .topCalories = &topCalories};
    double time_in_sec = time_callback(execute, &con);
    printf("max = %d\n", add(con.topCalories));
    printf("execution time: %lf seconds.\n", time_in_sec);
    array_free(&topCalories);
  }
  return 0;
}
