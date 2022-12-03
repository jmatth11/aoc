#include <time.h>

#ifndef AOC_UTILS
#define AOC_UTILS
// utility macros/functions

#define macro_var(name) name##__LINE__
#define defer(start, end)                                                      \
  for (int macro_var(_i_) = (start, 0); !macro_var(_i_);                       \
       (macro_var(_i_) += 1), end)

/**
 * Convenient callback typedef.
 */
typedef void* (*callback_t)(void*);

/**
 * Time how long it takes to execute a function.
 * @param[in] callback_t Callback function.
 * @param[in] void* Context object to pass into callback.
 * @return double The time elapsed in seconds.
 */
static double time_callback(callback_t c, void* context) {
  clock_t start;
  start = clock();
  c(context);
  return ((double)(clock() - start)) / CLOCKS_PER_SEC;
}

#endif
