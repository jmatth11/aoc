#include <stdlib.h>

struct array_t {
  int *data;
  int len;
  int cap;
  void (*add)(struct array_t *const, const int);
  void (*get)(struct array_t *const, const int, int *);
  void (*remove)(struct array_t *const, const int, int *);
};

void array_init(struct array_t *const, const size_t);
void array_free(struct array_t *const);
