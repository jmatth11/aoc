#include <math.h>
#include <string.h>

#include "array.h"

#define RESIZE_CONST 1.7

static void add_value(struct array_t *arr, int item) {
  if (arr->len < arr->cap) {
    arr->data[arr->len] = item;
    arr->len = arr->len + 1;
    return;
  }
  int newCap = ceil(arr->cap * RESIZE_CONST);
  arr->data = (int *)realloc(arr->data, newCap * sizeof(int));
  memset(&arr->data[arr->len], 0, newCap - arr->len);
}

static void get_value(struct array_t *const arr, const int index, int *out) {
  if (index >= arr->len) {
    return;
  }
  *out = arr->data[index];
}

static void remove_value(struct array_t *const arr, const int index, int *out) {
  if (index >= arr->len) {
    return;
  }
  *out = arr->data[index];
  if (index == (arr->len - 1)) {
    arr->data[index] = 0;
    arr->len = arr->len - 1;
    return;
  }
  for (int i = index; i < (arr->len - 1); ++i) {
    arr->data[i] = arr->data[i + 1];
  }
  arr->data[arr->len - 1] = 0;
}

void array_init(struct array_t *const arr, const size_t n) {
  size_t cap = n;
  if (n <= 0)
    cap = 1;
  arr->data = (int *)calloc(n, sizeof(int));
  arr->cap = cap;
  arr->len = 0;
  arr->add = add_value;
  arr->get = get_value;
  arr->remove = remove_value;
}

void array_free(struct array_t *const arr) {
  free(arr->data);
  arr->data = NULL;
  arr->len = arr->cap = 0;
  arr->add = NULL;
  arr->get = NULL;
  arr->remove = NULL;
}

void array_map(struct array_t *const arr, map_callback_t callback,
               void *context) {
  for (int i = 0; i < arr->len; ++i) {
    callback(arr->data[i], context);
  }
}
