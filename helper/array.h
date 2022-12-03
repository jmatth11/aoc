#include <stdlib.h>

#ifndef AOC_ARRAY_TYPE
#define AOC_ARRAY_TYPE

/**
 * Simple array type with some convenience functions.
 */
struct array_t {
  int *data;
  int len;
  int cap;
  void (*add)(struct array_t *const, const int);
  void (*get)(struct array_t *const, const int, int *);
  void (*remove)(struct array_t *const, const int, int *);
};

/**
 * Initialize the array.
 * @param[in,out] struct array_t*const The array_t object to initialize.
 * @param[in] const size_t The size to initialize the array to.
 */
void array_init(struct array_t *const, const size_t);

/**
 * Free internal contents of array.
 * @param[in,out] struct array_t*const The array_t object to free.
 */
void array_free(struct array_t *const);

#endif
