// utility macros/functions

#define macro_var(name) name##__LINE__
#define defer(start, end) for ( \
  int macro_var(_i_) = (start, 0); \
  !macro_var(_i_); \
  (macro_var(_i_) += 1), end) \



/**
 * Convenient callback typedef.
 */
typedef void (*callback_t)();
