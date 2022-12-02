#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../helper/utils.h"
#include "../helper/array.h"

#define LINE_SIZE 20

void shift_top_calories(struct array_t *const arr, int curMax) {
    if (arr->len < arr->cap) {
        arr->data[arr->len] = curMax;
        arr->len = arr->len + 1;
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
    defer(inputFile = fopen(argv[1], "r"), fclose(inputFile))
    {
        char line[LINE_SIZE];
        int curMax = 0;
        if (inputFile == NULL) fprintf(stderr, "couldn't open input file.");
        while (fgets(line, LINE_SIZE, inputFile) != NULL) {
            if (strcmp(line, "\n") == 0) {
                shift_top_calories(&topCalories, curMax);
                curMax = 0;
                continue;
            }
            curMax = curMax + strtol(line, NULL, 10);
        }
        shift_top_calories(&topCalories, curMax);
        printf("max = %d\n", add(&topCalories));
        free(topCalories.data);
    }
    return 0;
}
